// ----------------------------------------------------------------------------
//
//  NestedErrorImpl.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class NestedErrorImpl: NestedError
{
// MARK: - Construction

    public convenience init(entity: ResponseEntity<NSData>) {
        self.init(entity: entity, cause: nil)
    }

    public init(entity: ResponseEntity<NSData>, cause: ErrorType?)
    {
        // Init instance variables
        self.entity = entity
        self.cause = cause
    }

// MARK: - Properties

    public let entity: ResponseEntity<NSData>

    public let cause: ErrorType?

}

// ----------------------------------------------------------------------------

extension NestedErrorImpl: ResponseEntityHolder
{
// MARK: - Functions

    public func getResponseEntity() -> ResponseEntity<NSData> {
        return self.entity
    }

    public func getResponseBodyAsBytes() -> NSData? {
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
