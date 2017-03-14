// ----------------------------------------------------------------------------
//
//  HttpCookie.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

@objc public protocol HttpCookie: RXMCustomStringConvertible
{
// MARK: - Properties

    /// Returns a dictionary representation of the receiver.
    var properties: [String: AnyObject]? { get }

    /// Returns the "Domain" attribute.
    var domain: String { get }

    /// Returns the "Name" of this cookie.
    var name: String { get }

    /// Returns the "Path" attribute.
    var path: String { get }

// MARK: - Functions

    /// Reports whether this http cookie has expired according to the time passed in or not.
    func isExpired(date: NSDate) -> Bool

    /// Reports whether this http cookie has expired or not.
    func isExpired() -> Bool

    /// Checks if this cookie matches the given URL.
    func matchesURL(url: NSURL) -> Bool

}

// ----------------------------------------------------------------------------
