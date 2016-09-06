// ----------------------------------------------------------------------------
//
//  Result.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public enum BasicEnumResult<T,E>
{
// MARK: - Construction

    case Success(T)
    case Failure(E)

}

// ----------------------------------------------------------------------------

public protocol EnumResultType
{
// MARK: - Functions

    func map(type: Self) -> BasicEnumResult<SuccessValue, FailureValue>

// MARK: - Inner Types

    associatedtype SuccessValue

    associatedtype FailureValue

}

// ----------------------------------------------------------------------------

extension BasicEnumResult: EnumResultType
{
// MARK: - Functions

    public func map(type: BasicEnumResult) -> BasicEnumResult<SuccessValue, FailureValue>
    {
        switch self
        {
            case .Success(let str):
                return .Success(str)

            case .Failure(let err):
                return .Failure(err)
        }
    }

// MARK: - Inner Types

    public typealias SuccessValue = T

    public typealias FailureValue = E

}

// ----------------------------------------------------------------------------

extension EnumResultType
{
// MARK: - Properties

    public var value: SuccessValue? {
        switch map(self) {
            case .Success(let box): return box
            case .Failure: return nil
        }
    }

    public var error: FailureValue? {
        switch map(self) {
            case .Success: return nil
            case .Failure(let err): return err
        }
    }

    public var isSuccess: Bool {
        switch map(self) {
            case .Success: return true
            case .Failure: return false
        }
    }

}

// ----------------------------------------------------------------------------
