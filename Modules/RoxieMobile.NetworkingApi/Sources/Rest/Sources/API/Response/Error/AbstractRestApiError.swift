// ----------------------------------------------------------------------------
//
//  AbstractRestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsLang

// ----------------------------------------------------------------------------

open class AbstractRestApiError: RestApiError, AbstractClass {

// MARK: - Construction

    public init(cause: Error?) {
        self.cause = cause
    }

// MARK: - Properties

    open var type: RestApiErrorType {
        raiseAbstractMethodException()
    }

    public let cause: Error?
}
