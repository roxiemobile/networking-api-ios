// ----------------------------------------------------------------------------
//
//  AbstractNestedError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

open class AbstractNestedError: NestedError, AbstractClass
{
// MARK: - Construction

    public convenience init(entity: ResponseEntity<Data>) {
        self.init(entity: entity, cause: nil)
    }

    public init(entity: ResponseEntity<Data>, cause: Error?)
    {
        // Init instance variables
        self.entity = entity
        self.cause = cause
    }

// MARK: - Properties

    open let entity: ResponseEntity<Data>

    open let cause: Error?

}

// ----------------------------------------------------------------------------

extension AbstractNestedError: ResponseEntityHolder
{
// MARK: - Functions

    public func getResponseEntity() -> ResponseEntity<Data> {
        return self.entity
    }

    public func getResponseBodyAsBytes() -> Data? {
        return self.entity.body
    }

    public func getResponseBodyAsString() -> String?
    {
        var result: String?

        if let entity = (try? StringConverter().convert(self.entity)) {
            result = entity.body
        }

        return result
    }

}

// ----------------------------------------------------------------------------

extension AbstractNestedError
{
// MARK: - Properties

    public var description: String
    {
        var result = typeName(self)

        if let cause = self.cause {
            result += "\nСaused by error: " + String(describing: cause).trim()
        }

        if let responseBody = getResponseBodyAsString() {
            result += "\nResponse body: \(responseBody)"
        }

        return result
    }

}

// ----------------------------------------------------------------------------
