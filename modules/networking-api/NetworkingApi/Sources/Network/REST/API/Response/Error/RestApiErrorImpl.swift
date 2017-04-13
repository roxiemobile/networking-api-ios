// ----------------------------------------------------------------------------
//
//  RestApiErrorImpl.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

open class RestApiErrorImpl: RestApiError
{
// MARK: - Construction

    public init(cause: Error?)
    {
        // Init instance variables
        self.cause = cause
    }

// MARK: - Properties

    open var type: RestApiErrorType {
        fatalError()
    }

    open let cause: Error?

}

// ----------------------------------------------------------------------------
