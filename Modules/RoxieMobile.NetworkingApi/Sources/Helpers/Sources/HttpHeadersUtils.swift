// ----------------------------------------------------------------------------
//
//  HttpHeadersUtils.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHttp
import SwiftCommonsLang

// ----------------------------------------------------------------------------

open class HttpHeadersUtils: NonCreatable {

// MARK: - Functions

    public static func merge(_ headers: HttpHeaders?, _ otherHeaders: HttpHeaders?) -> HttpHeaders {
        var result = HttpHeaders()

        // Put all Headers from first argument
        if let headers = headers, !(headers.isEmpty()) {
            result.putAll(headers.allHeaderFields)
        }

        // Merge Headers from second argument
        if let otherHeaders = otherHeaders, !(otherHeaders.isEmpty()) {
            for (key, value) in otherHeaders.allHeaderFields {
                result.remove(key)
                result.put(key, value: value)
            }
        }

        // Done
        return result
    }
}
