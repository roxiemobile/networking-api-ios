// ----------------------------------------------------------------------------
//
//  CookieUtils.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public final class CookieUtils: NonCreatable
{
// MARK: - Functions

    public class func cookie(cookieStore: HttpCookieStore, name: String) -> NSHTTPCookie?
    {
        var outCookie: NSHTTPCookie?

        // Search for Cookie with requested name
        for cookie in (cookieStore.cookies ?? []) {
            if cookie.name.lowercaseString == name.lowercaseString {
                outCookie = cookie
                break
            }
        }

        // Done
        return outCookie
    }

    public class func cookie(cookies: [HttpCookie], name: String) -> NSHTTPCookie?
    {
        var outCookie: NSHTTPCookie?

        // Search for Cookie with requested name
        for cookie in cookies {
            if cookie.name.lowercaseString == name.lowercaseString {
                outCookie = NSHTTPCookie(cookie)
                break
            }
        }

        // Done
        return outCookie
    }

    public class func isNullOrExpired(cookie: NSHTTPCookie?, offsetInSeconds offset: NSTimeInterval) -> Bool
    {
        guard let cookie = cookie else {
            return true
        }

        guard let expiresDate = cookie.expiresDate else {
            // From Apple documentation: nil if there is no specific expiration date such as in the case of “session-only” cookies
            // @link: https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSHTTPCookie_Class
            return false
        }

        // Check if cookie has expired
        return (NSDate(timeIntervalSinceNow: offset).compare(expiresDate) == .OrderedDescending)
    }

}

// ----------------------------------------------------------------------------
