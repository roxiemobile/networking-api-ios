// ----------------------------------------------------------------------------
//
//  FormBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import Alamofire
import SwiftCommons

// ----------------------------------------------------------------------------

public class FormBody: HttpBody
{
// MARK: - Construction

    private init(builder: FormBodyBuilder)
    {
        // Init instance variables
        self.formBody = builder.toData()
    }

// MARK: - Properties

    public var mediaType: MediaType? {
        return MediaType.ApplicationFormUrlencoded
    }

    public var body: NSData? {
        return self.formBody
    }

// MARK: - Variables

    private let formBody: NSData?

}

// ----------------------------------------------------------------------------

public class FormBodyBuilder
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Functions

    public func add(name: String, value: String) -> Self
    {
        self.values[name.trimmed()] = value.trimmed()
        return self
    }

    public func build() -> FormBody {
        return FormBody(builder: self)
    }

// MARK: - Private Functions

    private func toData() -> NSData?
    {
        let values = self.values.filter{ !($0.0.isEmpty) }

        // Build form url encoded string
        let components = values.map{ key, value -> String in
            // Escape parameters
            let key = ParameterEncoding.URL.escape(key)
            let value = ParameterEncoding.URL.escape(value)

            // Build string
            return "\(key)=\(value)"
        }

        // Join components
        let stringBody = components.joinWithSeparator("&")

        // Build bytes array
        return stringBody.dataUsingEncoding(NSUTF8StringEncoding)
    }

// MARK: - Variables

    private var values: [String: String] = [:]
}

// ----------------------------------------------------------------------------
