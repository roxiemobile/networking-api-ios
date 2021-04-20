// ----------------------------------------------------------------------------
//
//  ConnectionError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class ConnectionError: NestedError {

// MARK: - Construction

    public init(cause: Error?) {
        self.cause = cause
    }

// MARK: - Properties

    public let cause: Error?
}
