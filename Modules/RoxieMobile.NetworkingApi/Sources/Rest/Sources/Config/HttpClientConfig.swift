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
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public protocol HttpClientConfig: Cloneable {

// MARK: - Properties

    var connectionTimeout: TimeInterval { get }

    var readTimeout: TimeInterval { get }

    var interceptors: [Interceptor]  { get }

    var networkInterceptors: [Interceptor]  { get }

    var tlsConfig: TlsConfig?  { get }
}
