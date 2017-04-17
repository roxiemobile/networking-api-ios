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

public class AbstractRestApiError: RestApiError, AbstractClass
{
// MARK: - Construction

    public init(cause: ErrorType?)
    {
        // Init instance variables
        self.cause = cause
    }

// MARK: - Properties

    public var type: RestApiErrorType {
        raiseAbstractMethodException()
    }

    public let cause: ErrorType?

}

// ----------------------------------------------------------------------------
