// ----------------------------------------------------------------------------
//
//  RequestEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!
open class RequestEntity<T>
{
// MARK: - Construction

    init(url: URL?, headers: HttpHeaders?, cookies: [HttpCookieProtocol]?, body: T?)
    {
        // Init instance variables
        self.url = url
        self.headers = headers
        self.cookies = cookies
        self.body = body
    }

// MARK: - Properties

    open let url: URL?

    open let headers: HttpHeaders?

    open let cookies: [HttpCookieProtocol]?

    open let body: T?

}

// ----------------------------------------------------------------------------
