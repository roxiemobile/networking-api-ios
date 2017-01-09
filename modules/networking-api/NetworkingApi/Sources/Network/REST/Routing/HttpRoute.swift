// ----------------------------------------------------------------------------
//
//  HttpRoute.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import SwiftCommons

// ----------------------------------------------------------------------------

public final class HttpRoute
{
// MARK: - Construction

    private init(url: NSURL)
    {
        // Init instance variables
        self.url = url
    }

// MARK: - Properties

    public let url: NSURL

// MARK: - Functions

    public static func buildRoute(baseURL: NSURL, path: String? = nil, params: QueryParams? = nil) -> HttpRoute
    {
        // Build new URL
        var urlString = (baseURL.absoluteString ?? "")

        // Append path to URL
        if let path = path {
            urlString += path.trimmed()
        }

        // Append query params to URL
        if let params = params where !(params.isEmpty) {
            urlString += "?" + buildQueryString(params)
        }

        // Build new HTTP route
        var route: HttpRoute!
        if let url = NSURL(string: urlString) {
            route = HttpRoute(url: url)
        }

        // Validate result
        if (route == nil) {
            rxm_fatalError("Could not create HTTP route for path ‘\(path)’.")
        }
        
        // Done
        return route
    }

// MARK: - Private Functions

    private static func buildQueryString(params: QueryParams) -> String
    {
        var components: [String] = []

        for (key, values) in params.items {
            components.appendContentsOf(buildQueryStringComponents(key, values: values))
        }

        // Done
        return components.joinWithSeparator("&")
    }

    private static func buildQueryStringComponents(key: String, values: [String]) -> [String]
    {
        if values.isEmpty { rxm_fatalError("") }

        var components: [String] = []
        var encodedValue: String

        if (values.count > 1) {
            for value in values {
                encodedValue = ParameterEncoding.URL.escape(key) + "[]=" + ParameterEncoding.URL.escape(value)
                components.append(encodedValue)
            }
        }
        else {
            encodedValue = ParameterEncoding.URL.escape(key) + "=" + ParameterEncoding.URL.escape(values[0])
            components.append(encodedValue)
        }

        // Done
        return components
    }

}

// ----------------------------------------------------------------------------
