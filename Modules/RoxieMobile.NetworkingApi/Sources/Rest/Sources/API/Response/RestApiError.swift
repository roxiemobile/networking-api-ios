// ----------------------------------------------------------------------------
//
//  RestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public protocol RestApiError: NestedError {

// MARK: - Properties

    /**
    * Returns the type of an error.
    */
    var type: RestApiErrorType { get }

    /**
    * Returns the cause of this {@code RestApiError}, or {@code null} if there is no cause.
    */
    var cause: Error? { get }
}

// ----------------------------------------------------------------------------

/**
* The type of an error.
*/
public enum RestApiErrorType {
    case transportLayer
    case applicationLayer
    case topLevelProtocol
}
