// ----------------------------------------------------------------------------
//
//  RedirectInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public protocol RedirectInterceptor: Interceptor {

// MARK: - Functions

    func onRedirect(_ httpResponse: HttpResponse) throws -> HttpResponse
}
