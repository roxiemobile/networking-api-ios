// ----------------------------------------------------------------------------
//
//  NetworkConfig.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public class NetworkConfig: NonCreatable {

// MARK: - Constants

    public struct Timeout {
        public static let Connection: TimeInterval = 60
        public static let Request: TimeInterval = 60
    }
}
