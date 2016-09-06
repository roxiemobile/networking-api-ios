// ----------------------------------------------------------------------------
//
//  RequestEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!

// ----------------------------------------------------------------------------

public class RequestEntity<T>
{
// MARK: - Construction

    init(url: NSURL?, headers: HttpHeaders?, cookies: [HttpCookie]?, body: T?)
    {
        // Init instance variables
        self.url = url
        self.headers = headers
        self.cookies = cookies
        self.body = body
    }

// MARK: - Properties

    public let url: NSURL?

    public let headers: HttpHeaders?

    public let cookies: [HttpCookie]?

    public let body: T?

}

// ----------------------------------------------------------------------------
