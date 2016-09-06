// ----------------------------------------------------------------------------
//
//  HttpHeadersUtils.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class HttpHeadersUtils: NonCreatable
{
// MARK: - Functions

    public static func merge(headers: HttpHeaders?, _ otherHeaders: HttpHeaders?) -> HttpHeaders
    {
        var result = HttpHeaders()

        // Put all Headers from first argument
        if let headers = headers where !(headers.isEmpty()) {
            result.putAll(headers.allHeaderFields)
        }

        // Merge Headers from second argument
        if let otherHeaders = otherHeaders where !(otherHeaders.isEmpty()) {
            for (key, value) in otherHeaders.allHeaderFields {
                result.remove(key)
                result.put(key, value: value)
            }
        }
        
        // Done
        return result
    }

}

// ----------------------------------------------------------------------------
