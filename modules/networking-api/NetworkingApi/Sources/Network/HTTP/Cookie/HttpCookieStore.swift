// ----------------------------------------------------------------------------
//
//  HttpCookieStore.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public protocol HttpCookieStore
{
// MARK: - Properties

    /// Get all cookies in cookie store which are not expired.
    var cookies: [NSHTTPCookie]? { get }

// MARK: - Functions

    /// Saves a HTTP cookie to this store.
    func setCookie(cookie: NSHTTPCookie)

    /// Retrieves cookies that match the specified URI.
    func cookiesForURL(URL: NSURL) -> [NSHTTPCookie]?

    /// Remove the specified cookie from the store.
    func deleteCookie(cookie: NSHTTPCookie)

}

// ----------------------------------------------------------------------------
