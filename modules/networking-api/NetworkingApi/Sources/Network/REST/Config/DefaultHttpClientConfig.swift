// ----------------------------------------------------------------------------
//
//  DefaultHttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

open class DefaultHttpClientConfig: HttpClientConfig
{
// MARK: - Methods

    open func connectTimeout() -> TimeInterval {
        return NetworkConfig.Timeout.Connection
    }

    open func readTimeout() -> TimeInterval {
        return NetworkConfig.Timeout.Connection
    }

    open func interceptors() -> [Interceptor] {
        return Inner.Interceptors
    }

    open func networkInterceptors() -> [Interceptor] {
        return Inner.NetworkInterceptors
    }

// MARK: - Constants

    fileprivate struct Inner
    {
        static let Interceptors: [Interceptor] = []

        static let NetworkInterceptors: [Interceptor] = {
            var networkInterceptors: [Interceptor] = []

            if Logger.isLoggable(.Debug) {
                networkInterceptors.append(HttpLoggingInterceptor())
            }

            return networkInterceptors
        }()
    }

}

// ----------------------------------------------------------------------------
