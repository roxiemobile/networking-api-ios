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

public class DefaultHttpClientConfig: HttpClientConfig
{
// MARK: - Methods

    public func connectTimeout() -> NSTimeInterval {
        return NetworkConfig.Timeout.Connection
    }

    public func readTimeout() -> NSTimeInterval {
        return NetworkConfig.Timeout.Connection
    }

    public func interceptors() -> [Interceptor] {
        return Inner.Interceptors
    }

    public func networkInterceptors() -> [Interceptor] {
        return Inner.NetworkInterceptors
    }

// MARK: - Constants

    private struct Inner
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
