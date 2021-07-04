// ----------------------------------------------------------------------------
//
//  HttpCookieProtocol.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsLang

// ----------------------------------------------------------------------------

@objc
public protocol HttpCookieProtocol: CustomStringConvertibleObjC {

// MARK: - Properties

    /// Returns a dictionary representation of the receiver.
    var properties: [HTTPCookiePropertyKey: Any]? { get }

    /// Returns the "Domain" attribute.
    var domain: String { get }

    /// Returns the "Name" of this cookie.
    var name: String { get }

    /// Returns the "Path" attribute.
    var path: String { get }

// MARK: - Functions

    /// Reports whether this http cookie has expired according to the time passed in or not.
    func isExpired(_ date: Date) -> Bool

    /// Reports whether this http cookie has expired or not.
    func isExpired() -> Bool

    /// Checks if this cookie matches the given URL.
    func matchesURL(_ url: URL) -> Bool
}

// ----------------------------------------------------------------------------

public typealias HttpCookie = HttpCookieProtocol
