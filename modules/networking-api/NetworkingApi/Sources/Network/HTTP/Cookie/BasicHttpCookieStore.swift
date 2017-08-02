// ----------------------------------------------------------------------------
//
//  BasicHttpCookieStore.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public class BasicHttpCookieStore: NSHTTPCookieStorage
{
// MARK: - Construction

    public init(cookies: [AnyObject]?) {
        super.init()

        // Init instance variables
        self.cookieStore = extractCookies(cookies ?? [AnyObject]())
    }

    public override init() {
        super.init()
    }

// MARK: - Properties

    public override var cookies: [NSHTTPCookie]? {
        return Array(self.cookieStore.values) as? [NSHTTPCookie]
    }

// MARK: - Functions

    public override func setCookie(cookie: NSHTTPCookie) {
        add(cookie)
    }

    public override func setCookies(cookies: [NSHTTPCookie], forURL URL: NSURL?, mainDocumentURL: NSURL?)
    {
        if (self.cookieAcceptPolicy == .Never) { return }

        var changed = false

        // Add Cookies to the CookieStore
        for object in cookies
        {
            let cookie = object
            
            if (self.cookieAcceptPolicy == .OnlyFromMainDocumentDomain) && (mainDocumentURL != nil)
            {
                let domain = cookie.domain
                let host = mainDocumentURL!.host
                
                if (host != nil) && ((domain.hasPrefix(".") && host!.hasSuffix(domain)) || (host! == domain)) {
                    changed = add(cookie, notify: false) || changed
                }
            }
            else {
                changed = add(cookie, notify: false) || changed
            }
        }

        // Post notification if needed
        if changed {
            postCookiesChangedNotification()
        }
    }

    public override func cookiesForURL(URL: NSURL) -> [NSHTTPCookie]? {
        return get(URL) as? [NSHTTPCookie]
    }

    public override func deleteCookie(cookie: NSHTTPCookie) {
        remove(cookie)
    }

    public override func removeCookiesSinceDate(date: NSDate)
    {
        // NOTE: Shallow copy
        let cookies = self.cookieStore
        var changed = false

        // Remove NON expired HTTP cookies only
        for (_, cookie) in cookies
        {
            if !cookie.isExpired(date) {
                changed = remove(cookie, notify: false) || changed
            }
        }

        // Post notification if needed
        if changed {
            postCookiesChangedNotification()
        }
    }

    @available(iOS, introduced=5.0)
    public override func sortedCookiesUsingDescriptors(sortOrder: [NSSortDescriptor]) -> [NSHTTPCookie] {
        let cookies = (Array(self.cookieStore.values) as NSArray).sortedArrayUsingDescriptors(sortOrder)
        return (cookies as? [NSHTTPCookie]) ?? [NSHTTPCookie]()
    }

    @available(iOS, introduced=8.0)
    public override func storeCookies(cookies: [NSHTTPCookie], forTask task: NSURLSessionTask) {
        setCookies(cookies, forURL: task.currentRequest?.URL, mainDocumentURL: nil)
    }

    @available(iOS, introduced=8.0)
    public override func getCookiesForTask(task: NSURLSessionTask, completionHandler: (([NSHTTPCookie]?) -> Void))
    {
        var cookies: [NSHTTPCookie]?

        if let url = task.currentRequest?.URL {
            cookies = cookiesForURL(url)
        }

        completionHandler(cookies)
    }

// MARK: - Private Functions

    private func extractCookies(objects: [AnyObject]) -> [String: HttpCookie]
    {
        var cookieStore = [String: HttpCookie]()

        // Look up for valid HTTP cookies only
        for object in objects
        {
            if let cookie = NSHTTPCookie(object as? HttpCookie) where !cookie.isExpired() {
                cookieStore[key(cookie)] = cookie
            }
        }

        // Done
        return cookieStore
    }

    private func key(cookie: HttpCookie) -> String
    {
        let path = cookie.path
        return (cookie.domain + (":" + path) + ":" + cookie.name)
    }

// MARK: - Variables

    private var cookieStore = [String: HttpCookie]()

}

// ----------------------------------------------------------------------------
// MARK: - @protocol HttpCookieStore
// ----------------------------------------------------------------------------

extension BasicHttpCookieStore
{
// MARK: - Functions

    /**
     * Saves a HTTP cookie to this store.
     */
    public func add(cookie: HttpCookie) {
        add(cookie, notify: true)
    }

    /**
     * Retrieves cookies that match the specified URI.
     *
     * @returns not expired cookies.
     */
    public func get(url: NSURL) -> [HttpCookie]
    {
        var cookies = [HttpCookie]()

        // Search for corresponded HTTP cookies only
        for (_, cookie) in self.cookieStore
        {
            if cookie.matchesURL(url) {
                cookies.append(cookie)
            }
        }

        // Done
        return cookies
    }

    /**
     * Remove the specified cookie from the store.
     *
     * @returns TRUE if the specified cookie is contained in this store and removed successfully.
     */
    public func remove(cookie: HttpCookie) -> Bool {
        return remove(cookie, notify: true)
    }

    /**
     * Clear this cookie store.
     *
     * @returns TRUE if any cookies were removed as a result of this call.
     */
    public func removeAll() -> Bool
    {
        let result = !self.cookieStore.isEmpty
        if  result
        {
            // Remove all Cookies from CookieStore
            self.cookieStore.removeAll()

            // Post notification
            postCookiesChangedNotification()
        }

        // Done
        return result
    }

// MARK: - Private Functions

    /**
     * Saves a HTTP cookie to this store AND posts notification if needed.
     */
    private func add(cookie: HttpCookie, notify: Bool) -> Bool
    {
        if (self.cookieAcceptPolicy == .Never) { return false }

        // Add new Cookie to the CookieStore
        self.cookieStore[key(cookie)] = cookie

        // Post notification if needed
        if notify {
            postCookiesChangedNotification()
        }

        // Done
        return true
    }

    /**
     * Removes the specified cookie from the store AND posts notification if needed.
     *
     * @returns TRUE if the specified cookie is contained in this store and removed successfully.
     */
    private func remove(cookie: HttpCookie, notify: Bool) -> Bool
    {
        let changed = (self.cookieStore.removeValueForKey(key(cookie)) != nil)

        // Post notification if needed
        if changed && notify {
            postCookiesChangedNotification()
        }

        // Done
        return changed
    }

    /**
     * Posts notification NSHTTPCookieManagerCookiesChangedNotification.
     */
    private func postCookiesChangedNotification()
    {
        weak var instance = self

        // .. on main thread
        mdc_dispatch_main_sync()
        {
            var notificationCenter: NSNotificationCenter!
#if os(iOS)
            notificationCenter = NSNotificationCenter.defaultCenter()
#elseif os(OSX)
            notificationCenter = NSDistributedNotificationCenter.defaultCenter()
#else
            mdc_fatalException("It's that mythical new Apple product.")
#endif
            // Post notification
            notificationCenter.postNotificationName(NSHTTPCookieManagerCookiesChangedNotification, object: instance)
        }
    }

}

// ----------------------------------------------------------------------------
// MARK: - @protocol Printable, DebugPrintable
// ----------------------------------------------------------------------------

extension BasicHttpCookieStore // : CustomDebugStringConvertible
{
// MARK: - Properties

    public override var description: String
    {
        var output = ""

        for cookie in self.cookieStore.values {
            output += "  " + cookie.description + "\n"
        }

        if !output.isEmpty {
            output = "cookies:\n" + output
        }

        output = "<\(typeName(self)) cookies count:\(self.cookieStore.count) \(output)>"

        // Done
        return output
    }

    public override var debugDescription: String {
        return self.description
    }

}

// ----------------------------------------------------------------------------
