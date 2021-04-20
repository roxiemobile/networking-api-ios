// ----------------------------------------------------------------------------
//
//  HttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public protocol HttpClientConfig {

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
