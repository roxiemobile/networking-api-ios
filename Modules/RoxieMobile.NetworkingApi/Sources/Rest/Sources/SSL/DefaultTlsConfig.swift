// ----------------------------------------------------------------------------
//
//  DefaultTlsConfig.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2022, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Alamofire

// ----------------------------------------------------------------------------

public struct DefaultTlsConfig: TlsConfig {

// MARK: - Construction

    public static let shared = DefaultTlsConfig()

    private init() {
        // Do nothing
    }

// MARK: - Properties

    public var trustManager: ServerTrustManager? = nil

// MARK: - Methods

    public func clone() -> Self {
        return Self.init()
    }
}
