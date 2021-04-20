// ----------------------------------------------------------------------------
//
//  ResponseEntity.swift
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
open class ResponseEntity<T>: RequestEntity<T> {

// MARK: - Construction

    init(
        url: URL?,
        headers: HttpHeaders?,
        cookies: [HttpCookieProtocol]?,
        body: T?,
        status: HttpStatus?,
        mediaType: MediaType?
    ) {

        self.status = status
        self.mediaType = mediaType

        // Parent processing
        super.init(url: url, headers: headers, cookies: cookies, body: body)
    }

// MARK: - Properties

    public let status: HttpStatus?

    public let mediaType: MediaType?
}
