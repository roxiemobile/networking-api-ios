// ----------------------------------------------------------------------------
//
//  AbstractRestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

open class AbstractRestApiError: RestApiError, AbstractClass
{
// MARK: - Construction

    public init(cause: Error?)
    {
        // Init instance variables
        self.cause = cause
    }

// MARK: - Properties

    open var type: RestApiErrorType {
        raiseAbstractMethodException()
    }

    open let cause: Error?

}

// ----------------------------------------------------------------------------
