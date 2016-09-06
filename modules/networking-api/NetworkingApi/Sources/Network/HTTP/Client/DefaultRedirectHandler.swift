// ----------------------------------------------------------------------------
//
//  DefaultRedirectHandler.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

class DefaultRedirectHandler: RedirectHandler
{
// MARK: - Construction

    init(allowRedirects: Bool)
    {
        // Init instance variables
        self.allowRedirects = allowRedirects
    }

// MARK: - Properties

    private(set) var lastRedirectUrl: NSURL?

    private(set) var allowRedirects: Bool

// MARK: - Functions

    func onShouldPerformHttpRedirection(response: NSHTTPURLResponse, newRequest: NSURLRequest) -> Bool
    {
        var result = self.allowRedirects
        if  result
        {
            // Redirection allowed for GET requests only
            result = newRequest.HTTPMethod?.caseInsensitiveCompare(Method.GET.rawValue) == .OrderedSame
            self.lastRedirectUrl = newRequest.URL
        }

        // Done
        return result
    }

}

// ----------------------------------------------------------------------------
