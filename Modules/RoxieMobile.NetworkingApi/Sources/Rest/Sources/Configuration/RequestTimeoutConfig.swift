// ----------------------------------------------------------------------------
//
//  RequestTimeoutConfig.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2022, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public protocol RequestTimeoutConfig: Cloneable {

// MARK: - Properties

    /// Gets connection timeout.
    ///
    /// - Returns:
    ///   The connection timeout in seconds.
    ///
    var connectionTimeout: TimeInterval { get }

    /// Gets read timeout.
    ///
    /// - Returns:
    ///   The read timeout in seconds.
    ///
    var readTimeout: TimeInterval { get }
}
