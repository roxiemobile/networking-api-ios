// ----------------------------------------------------------------------------
//
//  DefaultHttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsLogging

// ----------------------------------------------------------------------------

public struct DefaultHttpClientConfig: HttpClientConfig {

// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Properties

    public let connectionTimeout: TimeInterval = NetworkConfig.Timeout.connection

    public let readTimeout: TimeInterval = NetworkConfig.Timeout.read

    public let interceptors: [Interceptor] = []

    public let networkInterceptors: [Interceptor] = Self.createNetworkInterceptors()

    public let tlsConfig: TlsConfig? = nil

// MARK: - Methods

    public func clone() -> Self {
        return Self.init()
    }

// MARK: - Private Methods

    private static func createNetworkInterceptors() -> [Interceptor] {
        var networkInterceptors: [Interceptor] = []

        // Interceptor which adds an Alamofire library's version to an User-Agent's header
        networkInterceptors.append(UserAgentRequestInterceptor())

        // Interceptor which logs request and response information
        if Logger.isLoggable(.debug) {
            networkInterceptors.append(HttpLoggingInterceptor())
        }

        return networkInterceptors
    }
}
