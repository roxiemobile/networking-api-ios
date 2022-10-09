// ----------------------------------------------------------------------------
//
//  RequestEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp

// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!
open class RequestEntity<T> {

// MARK: - Construction

    internal init(url: URL?, headers: HttpHeaders?, cookieStorage: HTTPCookieStorage, body: T?) {
        self.url = url
        self.headers = headers
        self.cookieStorage = cookieStorage
        self.body = body
    }

// MARK: - Properties

    public let url: URL?

    public let headers: HttpHeaders?

    public let cookieStorage: HTTPCookieStorage

    public let body: T?
}
