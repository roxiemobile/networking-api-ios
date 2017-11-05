// ----------------------------------------------------------------------------
//
//  ResponseEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!
open class ResponseEntity<T>: RequestEntity<T>
{
// MARK: - Construction

    init(url: URL?, headers: HttpHeaders?, cookies: [HttpCookieProtocol]?, body: T?, status: HttpStatus?, mediaType: MediaType?)
    {
        // Init instance variables
        self.status = status
        self.mediaType = mediaType

        // Parent processing
        super.init(url: url, headers: headers, cookies: cookies, body: body)
    }

// MARK: - Properties

    open let status: HttpStatus?

    open let mediaType: MediaType?

}

// ----------------------------------------------------------------------------
