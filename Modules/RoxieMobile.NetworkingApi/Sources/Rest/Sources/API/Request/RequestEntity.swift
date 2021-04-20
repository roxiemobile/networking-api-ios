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

    init(url: URL?, headers: HttpHeaders?, cookies: [HttpCookieProtocol]?, body: T?) {
        self.url = url
        self.headers = headers
        self.cookies = cookies
        self.body = body
    }

// MARK: - Properties

    public let url: URL?

    public let headers: HttpHeaders?

    public let cookies: [HttpCookieProtocol]?

    public let body: T?
}
