// ----------------------------------------------------------------------------
//
//  LogUtils.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

class LogUtils: NonCreatable
{
// MARK: - Functions

    static func logRequest(request: NSURLRequest)
    {
        guard Logger.isLoggable(.DEBUG) else { return }

        // Log URL
        let url = (request.URL?.absoluteString ?? "")
        let method = (request.HTTPMethod ?? "")
        Logger.d(String(format: "[%p/rqst-url] %@ %@", request, method, url))

        // Log Headers
        Logger.d(String(format: "[%p/rqst-headers] %@", request, request.allHTTPHeaderFields ?? [:]))

        // Log Body
        if let body = String(data: (request.HTTPBody ?? NSData()), encoding: NSUTF8StringEncoding) {
            Logger.d(String(format: "[%p/rqst-body] %@", request, body))
        }
    }

    static func logResponse(response: NSHTTPURLResponse, body: NSData?)
    {
        guard Logger.isLoggable(.DEBUG) else { return }

        // Log Status
        if let status = HttpStatus.valueOf(response.statusCode) {
            Logger.d(String(format: "[%p/resp-status] %d %@", response, status.code.rawValue, status.reasonPhrase))
        }
        else {
            Logger.d(String(format: "[%p/resp-status] %d", response, response.statusCode))
        }

        // Log Headers
        Logger.d(String(format: "[%p/resp-headers] %@", response, response.allHeaderFields))

        // Log Body
        if let body = String(data: (body ?? NSData()), encoding: NSUTF8StringEncoding) {
            Logger.d(String(format: "[%p/resp-body] %@", response, body))
        }
    }

}

// ----------------------------------------------------------------------------
