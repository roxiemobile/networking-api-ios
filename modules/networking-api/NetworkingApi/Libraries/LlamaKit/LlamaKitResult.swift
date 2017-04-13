/// LlamaKitResult
///
/// Container for a successful value (T) or a failure with an NSError
///

import Foundation

/// A success `LlamaKitResult` returning `value`
/// This form is preferred to `LlamaKitResult.Success(Box(value))` because it
// does not require dealing with `Box()`
public func success<T,E>(value: T) -> LlamaKitResult<T,E> {
  return .success(Box(value))
}

/// A failure `LlamaKitResult` returning `error`
/// The default error is an empty one so that `failure()` is legal
/// To assign this to a variable, you must explicitly give a type.
/// Otherwise the compiler has no idea what `T` is. This form is preferred
/// to LlamaKitResult.Failure(error) because it provides a useful default.
/// For example:
///    let fail: LlamaKitResult<Int> = failure()
///

/// Dictionary keys for default errors
public let LlamaErrorFileKey = "LlamaKit.LMErrorFile"
public let LlamaErrorLineKey = "LlamaKit.LMErrorLine"

private func defaultError(_ userInfo: [AnyHashable : Any]) -> NSError {
  return NSError(domain: "", code: 0, userInfo: userInfo)
}

private func defaultError(message: String, file: String = #file, line: Int = #line) -> NSError {
  return defaultError([NSLocalizedDescriptionKey: message, LlamaErrorFileKey: file, LlamaErrorLineKey: line])
}

private func defaultError(file: String = #file, line: Int = #line) -> NSError {
  return defaultError([LlamaErrorFileKey: file, LlamaErrorLineKey: line])
}

public func failure<T>(message: String, file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  let userInfo: [AnyHashable : Any] = [NSLocalizedDescriptionKey: message, LlamaErrorFileKey: file, LlamaErrorLineKey: line]
  return failure(defaultError(userInfo))
}

public func failure<T>(file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  let userInfo: [AnyHashable : Any] = [LlamaErrorFileKey: file, LlamaErrorLineKey: line]
  return failure(defaultError(userInfo))
}

public func failure<T,E>(_ error: E) -> LlamaKitResult<T,E> {
  return .failure(Box(error))
}

/// Construct a `LlamaKitResult` using a block which receives an error parameter.
/// Expected to return non-nil for success.

public func `try`<T>(f: ((NSErrorPointer) -> T?), file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  var error: NSError?
    return f(&error).map(success) ?? failure(error ?? defaultError(file: file, line: line))
}

public func `try`(f: ((NSErrorPointer) -> Bool), file: String = #file, line: Int = #line) -> LlamaKitResult<(),NSError> {
  var error: NSError?
    return f(&error) ? success(value: ()) : failure(error ?? defaultError(file: file, line: line))
}

/// Container for a successful value (T) or a failure with an E
public enum LlamaKitResult<T,E> {
  case success(Box<T>)
  case failure(Box<E>)

  /// The successful value as an Optional
  public var value: T? {
    switch self {
    case .success(let box): return box.unbox
    case .failure: return nil
    }
  }

  /// The failing error as an Optional
  public var error: E? {
    switch self {
    case .success: return nil
    case .failure(let err): return err.unbox
    }
  }

  public var isSuccess: Bool {
    switch self {
    case .success: return true
    case .failure: return false
    }
  }

  /// Return a new result after applying a transformation to a successful value.
  /// Mapping a failure returns a new failure without evaluating the transform
  public func map<U>(transform: (T) -> U) -> LlamaKitResult<U,E> {
    switch self {
    case .success(let box):
      return .success(Box(transform(box.unbox)))
    case .failure(let err):
      return .failure(err)
    }
  }

  /// Return a new result after applying a transformation (that itself
  /// returns a result) to a successful value.
  /// Calling with a failure returns a new failure without evaluating the transform
  public func flatMap<U>(transform:(T) -> LlamaKitResult<U,E>) -> LlamaKitResult<U,E> {
    switch self {
    case .success(let value):
      return transform(value.unbox)
    case .failure(let error):
      return .failure(error)
    }
  }
}

extension LlamaKitResult: CustomStringConvertible {
  public var description: String {
    switch self {
    case .success(let box):
      return "Success: \(box.unbox)"
    case .failure(let error):
      return "Failure: \(error.unbox)"
    }
  }
}

/// Failure coalescing
///    .Success(Box(42)) ?? 0 ==> 42
///    .Failure(NSError()) ?? 0 ==> 0
public func ??<T,E>(result: LlamaKitResult<T,E>, defaultValue: @autoclosure () -> T) -> T {
  switch result {
  case .success(let value):
    return value.unbox
  case .failure(_):
    return defaultValue()
  }
}

/// Equatable
/// Equality for LlamaKitResult is defined by the equality of the contained types
public func ==<T, E>(lhs: LlamaKitResult<T, E>, rhs: LlamaKitResult<T, E>) -> Bool where T: Equatable, E: Equatable {
    switch (lhs, rhs) {
    case let (.success(l), .success(r)): return l.unbox == r.unbox
    case let (.failure(l), .failure(r)): return l.unbox == r.unbox
    default: return false
    }
}

public func !=<T, E>(lhs: LlamaKitResult<T, E>, rhs: LlamaKitResult<T, E>) -> Bool where T: Equatable, E: Equatable {
  return !(lhs == rhs)
}

/// Due to current swift limitations, we have to include this Box in LlamaKitResult.
/// Swift cannot handle an enum with multiple associated data (A, NSError) where one is of unknown size (A)
public final class Box<T> {
  public let unbox: T
  public init(_ value: T) { self.unbox = value }
}
