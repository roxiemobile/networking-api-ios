// ----------------------------------------------------------------------------
//
//  HttpResponseError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public class HttpResponseError: ErrorType
{
// MARK: - Construction

    public init(httpResponse: HttpResponse)
    {
        // Init instance variables
        self.httpResponse = httpResponse
    }

// MARK: - Properties

    public let httpResponse: HttpResponse

}

// ----------------------------------------------------------------------------
