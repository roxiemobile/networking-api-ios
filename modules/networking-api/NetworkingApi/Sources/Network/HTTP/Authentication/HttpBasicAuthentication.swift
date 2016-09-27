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
        mdc_assert(str_isNotEmpty(username), message: "Username is empty")
        mdc_assert(str_isNotEmpty(password), message: "Password is empty")

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
