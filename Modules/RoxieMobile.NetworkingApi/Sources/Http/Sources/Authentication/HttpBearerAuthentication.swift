// ----------------------------------------------------------------------------
//
//  HttpBearerAuthentication.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsDiagnostics

// ----------------------------------------------------------------------------

open class HttpBearerAuthentication: HttpAuthentication {

// MARK: - Construction

    public init(token: String) {

        // Validate params
        Guard.notEmpty(token, "token is empty")

        // Init instance variables
        self.token = token
    }

// MARK: - Functions

    open override func getHeaderValue() -> String {
        return "Bearer " + self.token
    }

// MARK: - Variables

    fileprivate let token: String
}
