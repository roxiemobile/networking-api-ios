// ----------------------------------------------------------------------------
//
//  HttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol HttpClientConfig
{
// MARK: - Methods

    /**
     * TODO
     */
    func connectTimeout() -> TimeInterval

    /**
     * TODO
     */
    func readTimeout() -> TimeInterval


    /**
     * TODO
     */
    func interceptors() -> [Interceptor]


    /**
     * TODO
     */
    func networkInterceptors() -> [Interceptor]

}

// ----------------------------------------------------------------------------
