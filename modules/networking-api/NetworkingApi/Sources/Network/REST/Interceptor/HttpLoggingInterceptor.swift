// ----------------------------------------------------------------------------
//
//  HttpLoggingInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public class HttpLoggingInterceptor: Interceptor
{
// MARK: - Construction

    public init()
    {
        // Init instance variables
        self.customTag = rxm_customTag(self.dynamicType)
    }

// MARK: - Properties

    let customTag: String

// MARK: - Functions

    public func intercept(chain: InterceptorChain) throws -> HttpResponse
    {
        // Log request
        LogUtils.logRequest(chain.request)

        // Perform request
        let httpResponse = try chain.proceed(chain.request)

        // Log response
        LogUtils.logResponse(httpResponse.response, body: httpResponse.body)

        // Done
        return httpResponse
    }

}

// ----------------------------------------------------------------------------
