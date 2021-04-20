// ----------------------------------------------------------------------------
//
//  HttpCookieStore.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public protocol HttpCookieStore {

// MARK: - Properties

    /// Get all cookies in cookie store which are not expired.
    var cookies: [HTTPCookie]? { get }

// MARK: - Functions

    /// Saves a HTTP cookie to this store.
    func setCookie(_ cookie: HTTPCookie)

    /// Retrieves cookies that match the specified URI.
    func cookies(for URL: URL) -> [HTTPCookie]?

    /// Remove the specified cookie from the store.
    func deleteCookie(_ cookie: HTTPCookie)
}
