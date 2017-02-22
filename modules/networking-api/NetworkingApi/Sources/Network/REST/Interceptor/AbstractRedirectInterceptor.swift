// ----------------------------------------------------------------------------
//
//  AbstractRedirectInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class AbstractRedirectInterceptor: RedirectInterceptor, AbstractClass
{
// MARK: - Functions

    public func intercept(chain: InterceptorChain) throws -> HttpResponse
    {
        var result = try chain.proceed(chain.request)

        if (result.redirectRequest != nil) {
            result = try onRedirect(result)
        }

        return result
    }

    public func onRedirect(httpResponse: HttpResponse) throws -> HttpResponse {
        raiseAbstractMethodException()
    }

}

// ----------------------------------------------------------------------------
