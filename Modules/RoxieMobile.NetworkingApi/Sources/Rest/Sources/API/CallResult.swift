// ----------------------------------------------------------------------------
//
//  CallResult.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public enum CallResult<T> {

// MARK: - Construction

    case success(ResponseEntity<T>)
    case failure(RestApiError)
}

// ----------------------------------------------------------------------------

extension CallResult: EnumResultType {

// MARK: - Functions

    public func map(_ type: CallResult) -> BasicEnumResult<SuccessValue, FailureValue> {
        switch self {

            case .success(let str):
                return .success(str)

            case .failure(let err):
                return .failure(err)
        }
    }

// MARK: - Inner Types

    public typealias SuccessValue = ResponseEntity<T>

    public typealias FailureValue = RestApiError
}
