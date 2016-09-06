// ----------------------------------------------------------------------------
//
//  RestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol RestApiError: ErrorType
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

// MARK: - Functions

    /**
    * Sends a printable representation of this {@code RestApiError}'s description
    * to the consumer.
    */
    // TODO: ...
//    void printErrorDescription(Consumer<String> consumer);

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
