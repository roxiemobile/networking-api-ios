// ----------------------------------------------------------------------------
//
//  HttpResponse.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

open class HttpResponse {

// MARK: - Construction

    public init(response: HTTPURLResponse, body: Data? = nil, redirectRequest: URLRequest? = nil) {
        self.response = response
        self.body = body
        self.redirectRequest = redirectRequest
    }

// MARK: - Properties

    public let response: HTTPURLResponse

    public let body: Data?

    public let redirectRequest: URLRequest?
}

// ----------------------------------------------------------------------------

extension HttpResponse {

// MARK: - Construction

    func copy(body: Data?) -> HttpResponse {
        return HttpResponse(response: self.response, body: body, redirectRequest: self.redirectRequest)
    }
}
