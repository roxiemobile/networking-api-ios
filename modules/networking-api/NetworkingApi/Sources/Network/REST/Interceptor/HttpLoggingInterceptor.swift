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

open class HttpLoggingInterceptor: Interceptor
{
// MARK: - Construction

    public init()
    {
        // Init instance variables
        self.customTag = rxm_customTag(clazz: type(of: self))
    }

// MARK: - Properties

    let customTag: String

// MARK: - Functions

    open func intercept(_ chain: InterceptorChain) throws -> HttpResponse
    {
        // Log request
        LogUtils.log(self.customTag, request: chain.request)

        // Perform request
        let httpResponse = try chain.proceed(chain.request)

        // Log response
        LogUtils.log(self.customTag, response: httpResponse.response, body: httpResponse.body)

        // Done
        return httpResponse
    }

}

// ----------------------------------------------------------------------------
