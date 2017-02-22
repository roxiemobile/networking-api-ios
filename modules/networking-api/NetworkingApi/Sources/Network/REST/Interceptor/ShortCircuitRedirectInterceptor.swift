// ----------------------------------------------------------------------------
//
//  ShortCircuitRedirectInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class ShortCircuitRedirectInterceptor: AbstractRedirectInterceptor
{
// MARK: - Functions

    public override func onRedirect(httpResponse: HttpResponse) throws -> HttpResponse {
        throw HttpResponseError(httpResponse: httpResponse)
    }

}

// ----------------------------------------------------------------------------
