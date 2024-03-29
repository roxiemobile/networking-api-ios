// ----------------------------------------------------------------------------
//
//  AbstractRedirectInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsLang

// ----------------------------------------------------------------------------

open class AbstractRedirectInterceptor: RedirectInterceptor, AbstractClass {

// MARK: - Construction

    public init() {
        // Do nothing
    }


// MARK: - Functions

    open func intercept(_ chain: InterceptorChain) throws -> HttpResponse {
        var result = try chain.proceed(chain.request)

        if (result.redirectRequest != nil) {
            result = try onRedirect(result)
        }

        return result
    }

    open func onRedirect(_ httpResponse: HttpResponse) throws -> HttpResponse {
        raiseAbstractMethodException()
    }
}
