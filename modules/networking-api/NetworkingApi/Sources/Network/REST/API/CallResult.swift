// ----------------------------------------------------------------------------
//
//  CallResult.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public enum CallResult<T>
{
// MARK: - Construction

    case Success(ResponseEntity<T>)
    case Failure(RestApiError)

}

// ----------------------------------------------------------------------------

extension CallResult: EnumResultType
{
// MARK: - Functions

    public func map(type: CallResult) -> BasicEnumResult<SuccessValue, FailureValue>
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

    public typealias SuccessValue = ResponseEntity<T>

    public typealias FailureValue = RestApiError

}

// ----------------------------------------------------------------------------
