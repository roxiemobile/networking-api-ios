// ----------------------------------------------------------------------------
//
//  HttpBearerAuthentication.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class HttpBearerAuthentication: HttpAuthentication
{
// MARK: - Construction

    public init(token: String)
    {
        // Validate params
        Require.isNotEmpty(token, "Token is empty")

        // Init instance variables
        self.token = token
    }

// MARK: - Functions

    public override func getHeaderValue() -> String {
        return "Bearer " + self.token
    }

// MARK: - Variables

    private let token: String

}

// ----------------------------------------------------------------------------
