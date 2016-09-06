// ----------------------------------------------------------------------------
//
//  RestApiErrorImpl.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class RestApiErrorImpl: RestApiError
{
// MARK: - Construction

    public init(cause: ErrorType?)
    {
        // Init instance variables
        self.cause = cause
    }

// MARK: - Properties

    public var type: RestApiErrorType {
        fatalError()
    }

    public let cause: ErrorType?

}

// ----------------------------------------------------------------------------
