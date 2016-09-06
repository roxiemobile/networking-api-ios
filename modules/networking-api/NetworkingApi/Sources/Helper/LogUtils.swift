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
        guard MDLog.isLoggable(.DEBUG) else { return }

        // Log URL
        let url = (request.URL?.absoluteString ?? "")
        MDLog.d(String(format: "[%p/rqst-url] %@", request, url))

        // Log Headers
        MDLog.d(String(format: "[%p/rqst-headers] %@", request, request.allHTTPHeaderFields ?? [:]))

        // Log Body
        if let body = String(data: (request.HTTPBody ?? NSData()), encoding: NSUTF8StringEncoding) {
            MDLog.d(String(format: "[%p/rqst-body] %@", request, body))
        }
    }

    static func logResponse(response: NSHTTPURLResponse, body: NSData?)
    {
        guard MDLog.isLoggable(.DEBUG) else { return }

        // Log Status
        if let status = HttpStatus.valueOf(response.statusCode)
        {
            MDLog.d(String(format: "[%p/resp-status] %d %@", response, status.code.rawValue, status.reasonPhrase))
        }
        else {
            MDLog.d(String(format: "[%p/resp-status] %d", response, response.statusCode))
        }

        // Log Headers
        MDLog.d(String(format: "[%p/resp-headers] %@", response, response.allHeaderFields))

        // Log Body
        if let body = String(data: (body ?? NSData()), encoding: NSUTF8StringEncoding) {
            MDLog.d(String(format: "[%p/resp-body] %@", response, body))
        }
    }

}

// ----------------------------------------------------------------------------
