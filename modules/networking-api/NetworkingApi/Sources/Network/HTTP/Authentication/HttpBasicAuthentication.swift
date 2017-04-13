// ----------------------------------------------------------------------------
//
//  HttpBasicAuthentication.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

open class HttpBasicAuthentication: HttpAuthentication
{
// MARK: - Construction

    public init(username: String, password: String)
    {
        // Validate params
        Require.isNotEmpty(username, "Username is empty")
        Require.isNotEmpty(password, "Password is empty")

        // Init instance variables
        self.username = username
        self.password = password
    }

// MARK: - Functions

    open override func getHeaderValue() -> String
    {
        let data = (self.username + ":" + self.password).data(using: String.Encoding.utf8)!
        return "Basic " + data.base64EncodedString(options: [])
    }

// MARK: - Variables

    fileprivate let username: String

    fileprivate let password: String

}

// ----------------------------------------------------------------------------
