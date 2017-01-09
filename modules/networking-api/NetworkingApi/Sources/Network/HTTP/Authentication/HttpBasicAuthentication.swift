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

public class HttpBasicAuthentication: HttpAuthentication
{
// MARK: - Construction

    public init(username: String, password: String)
    {
        // Validate params
        Expect.isNotEmpty(username, "Username is empty")
        Expect.isNotEmpty(password, "Password is empty")

        // Init instance variables
        self.username = username
        self.password = password
    }

// MARK: - Functions

    public override func getHeaderValue() -> String
    {
        let data = (self.username + ":" + self.password).dataUsingEncoding(NSUTF8StringEncoding)!
        return "Basic " + data.base64EncodedStringWithOptions([])
    }

// MARK: - Variables

    private let username: String

    private let password: String

}

// ----------------------------------------------------------------------------
