/// LlamaKitResult
///
/// Container for a successful value (T) or a failure with an NSError
///

import Foundation

/// A success `LlamaKitResult` returning `value`
/// This form is preferred to `LlamaKitResult.Success(Box(value))` because it
// does not require dealing with `Box()`
public func success<T,E>(value: T) -> LlamaKitResult<T,E> {
  return .Success(Box(value))
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

private func defaultError(userInfo: [NSObject: AnyObject]) -> NSError {
  return NSError(domain: "", code: 0, userInfo: userInfo)
}

private func defaultError(message: String, file: String = #file, line: Int = #line) -> NSError {
  return defaultError([NSLocalizedDescriptionKey: message, LlamaErrorFileKey: file, LlamaErrorLineKey: line])
}

private func defaultError(file: String = #file, line: Int = #line) -> NSError {
  return defaultError([LlamaErrorFileKey: file, LlamaErrorLineKey: line])
}

public func failure<T>(message: String, file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  let userInfo: [NSObject : AnyObject] = [NSLocalizedDescriptionKey: message, LlamaErrorFileKey: file, LlamaErrorLineKey: line]
  return failure(defaultError(userInfo))
}

public func failure<T>(file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  let userInfo: [NSObject : AnyObject] = [LlamaErrorFileKey: file, LlamaErrorLineKey: line]
  return failure(defaultError(userInfo))
}

public func failure<T,E>(error: E) -> LlamaKitResult<T,E> {
  return .Failure(Box(error))
}

/// Construct a `LlamaKitResult` using a block which receives an error parameter.
/// Expected to return non-nil for success.

public func `try`<T>(f: (NSErrorPointer -> T?), file: String = #file, line: Int = #line) -> LlamaKitResult<T,NSError> {
  var error: NSError?
  return f(&error).map(success) ?? failure(error ?? defaultError(file, line: line))
}

public func `try`(f: (NSErrorPointer -> Bool), file: String = #file, line: Int = #line) -> LlamaKitResult<(),NSError> {
  var error: NSError?
  return f(&error) ? success(()) : failure(error ?? defaultError(file, line: line))
}

/// Container for a successful value (T) or a failure with an E
public enum LlamaKitResult<T,E> {
  case Success(Box<T>)
  case Failure(Box<E>)

  /// The successful value as an Optional
  public var value: T? {
    switch self {
    case .Success(let box): return box.unbox
    case .Failure: return nil
    }
  }

  /// The failing error as an Optional
  public var error: E? {
    switch self {
    case .Success: return nil
    case .Failure(let err): return err.unbox
    }
  }

  public var isSuccess: Bool {
    switch self {
    case .Success: return true
    case .Failure: return false
    }
  }

  /// Return a new result after applying a transformation to a successful value.
  /// Mapping a failure returns a new failure without evaluating the transform
  public func map<U>(transform: T -> U) -> LlamaKitResult<U,E> {
    switch self {
    case .Success(let box):
      return .Success(Box(transform(box.unbox)))
    case .Failure(let err):
      return .Failure(err)
    }
  }

  /// Return a new result after applying a transformation (that itself
  /// returns a result) to a successful value.
  /// Calling with a failure returns a new failure without evaluating the transform
  public func flatMap<U>(transform:T -> LlamaKitResult<U,E>) -> LlamaKitResult<U,E> {
    switch self {
    case .Success(let value):
      return transform(value.unbox)
    case .Failure(let error):
      return .Failure(error)
    }
  }
}

extension LlamaKitResult: CustomStringConvertible {
  public var description: String {
    switch self {
    case .Success(let box):
      return "Success: \(box.unbox)"
    case .Failure(let error):
      return "Failure: \(error.unbox)"
    }
  }
}

/// Failure coalescing
///    .Success(Box(42)) ?? 0 ==> 42
///    .Failure(NSError()) ?? 0 ==> 0
public func ??<T,E>(result: LlamaKitResult<T,E>, @autoclosure defaultValue: () -> T) -> T {
  switch result {
  case .Success(let value):
    return value.unbox
  case .Failure(_):
    return defaultValue()
  }
}

/// Equatable
/// Equality for LlamaKitResult is defined by the equality of the contained types
public func ==<T, E where T: Equatable, E: Equatable>(lhs: LlamaKitResult<T, E>, rhs: LlamaKitResult<T, E>) -> Bool {
    switch (lhs, rhs) {
    case let (.Success(l), .Success(r)): return l.unbox == r.unbox
    case let (.Failure(l), .Failure(r)): return l.unbox == r.unbox
    default: return false
    }
}

public func !=<T, E where T: Equatable, E: Equatable>(lhs: LlamaKitResult<T, E>, rhs: LlamaKitResult<T, E>) -> Bool {
  return !(lhs == rhs)
}

/// Due to current swift limitations, we have to include this Box in LlamaKitResult.
/// Swift cannot handle an enum with multiple associated data (A, NSError) where one is of unknown size (A)
public final class Box<T> {
  public let unbox: T
  public init(_ value: T) { self.unbox = value }
}
