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

    static func log(_ tag: String, request: URLRequest)
    {
        guard Logger.isLoggable(.debug) else { return }

        let hashString = request.hashValue.rxm_hexString

        // Log URL
        let url = (request.url?.absoluteString ?? "")
        let method = (request.httpMethod ?? "")
        Logger.d(tag, String(format: "[%d/rqst-url] %@ %@", hashString, method, url))

        // Log Headers
        Logger.d(tag, String(format: "[%p/rqst-headers] %@", hashString, request.allHTTPHeaderFields ?? [:]))

        // Log Body
        if let body = String(data: (request.httpBody ?? Data()), encoding: String.Encoding.utf8) {
            Logger.d(tag, String(format: "[%p/rqst-body] %@", hashString, body))
        }
    }

    static func log(_ tag: String, response: HTTPURLResponse, body: Data?)
    {
        guard Logger.isLoggable(.debug) else { return }

        let hashString = response.hashValue.rxm_hexString

        // Log Status
        if let status = HttpStatus.valueOf(response.statusCode) {
            Logger.d(tag, String(format: "[%p/resp-status] %d %@", hashString, status.code.rawValue, status.reasonPhrase))
        }
        else {
            Logger.d(tag, String(format: "[%p/resp-status] %d", hashString, response.statusCode))
        }

        // Log Headers
        Logger.d(tag, String(format: "[%p/resp-headers] %@", hashString, response.allHeaderFields))

        // Log Body
        if let body = String(data: (body ?? Data()), encoding: String.Encoding.utf8) {
            Logger.d(tag, String(format: "[%p/resp-body] %@", response, body))
        }
    }

}

// ----------------------------------------------------------------------------
