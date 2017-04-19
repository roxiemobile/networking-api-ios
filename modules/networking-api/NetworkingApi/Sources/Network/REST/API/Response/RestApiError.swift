// ----------------------------------------------------------------------------
//
//  RestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol RestApiError: NestedError
{
// MARK: - Properties

    /**
    * Returns the type of an error.
    */
    var type: RestApiErrorType { get }

    /**
    * Returns the cause of this {@code RestApiError}, or {@code null} if there is no cause.
    */
    var cause: ErrorType? { get }

}

// ----------------------------------------------------------------------------

/**
* The type of an error.
*/
public enum RestApiErrorType
{
    case TransportLayer
    case ApplicationLayer
    case TopLevelProtocol
}

// ----------------------------------------------------------------------------
