// ----------------------------------------------------------------------------
//
//  HttpResponseError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

open class HttpResponseError: Error {

// MARK: - Construction

    public init(httpResponse: HttpResponse) {
        self.httpResponse = httpResponse
    }

// MARK: - Properties

    public let httpResponse: HttpResponse
}
