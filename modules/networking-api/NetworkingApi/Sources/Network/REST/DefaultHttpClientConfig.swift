// ----------------------------------------------------------------------------
//
//  DefaultHttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
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

}

// ----------------------------------------------------------------------------
