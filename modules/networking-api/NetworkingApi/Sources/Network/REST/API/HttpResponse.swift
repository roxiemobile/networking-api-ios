// ----------------------------------------------------------------------------
//
//  HttpResponse.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public class HttpResponse
{
// MARK: - Construction

    public init(response: NSHTTPURLResponse, body: NSData? = nil, redirectRequest: NSURLRequest? = nil)
    {
        // Init instance variables
        self.response = response
        self.body = body
        self.redirectRequest = redirectRequest
    }

// MARK: - Properties

    public let response: NSHTTPURLResponse

    public let body: NSData?

    public let redirectRequest: NSURLRequest?

}

// ----------------------------------------------------------------------------

extension HttpResponse
{
// MARK: - Construction

    func copy(body body: NSData?) -> HttpResponse {
        return HttpResponse(response: self.response, body: body, redirectRequest: self.redirectRequest)
    }

}

// ----------------------------------------------------------------------------
