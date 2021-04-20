// ----------------------------------------------------------------------------
//
//  Interceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public protocol Interceptor {

// MARK: - Functions

    func intercept(_ chain: InterceptorChain) throws -> HttpResponse
}
