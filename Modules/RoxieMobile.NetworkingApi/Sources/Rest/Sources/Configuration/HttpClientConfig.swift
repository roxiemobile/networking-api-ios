// ----------------------------------------------------------------------------
//
//  HttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsLang

// ----------------------------------------------------------------------------

public protocol HttpClientConfig: Cloneable {

// MARK: - Properties

    var requestTimeoutConfig: RequestTimeoutConfig? { get }

    var tlsConfig: TlsConfig? { get }

    var interceptors: [Interceptor]? { get }

    var networkInterceptors: [Interceptor]? { get }
}
