// ----------------------------------------------------------------------------
//
//  ShortCircuitRedirectInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class ShortCircuitRedirectInterceptor: AbstractRedirectInterceptor {

// MARK: - Functions

    open override func onRedirect(_ httpResponse: HttpResponse) throws -> HttpResponse {
        throw HttpResponseError(httpResponse: httpResponse)
    }
}
