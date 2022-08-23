// ----------------------------------------------------------------------------
//
//  DefaultRequestTimeoutConfig.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2022, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public struct DefaultRequestTimeoutConfig: RequestTimeoutConfig {

// MARK: - Construction

    public static let shared = DefaultRequestTimeoutConfig()

    private init() {
        // Do nothing
    }

// MARK: - Properties

    public let connectionTimeout: TimeInterval = 30

    public let readTimeout: TimeInterval = 15

// MARK: - Methods

    public func clone() -> Self {
        return Self.init()
    }
}
