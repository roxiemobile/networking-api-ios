// ----------------------------------------------------------------------------
//
//  NestedErrorImpl.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

open class NestedErrorImpl: NestedError
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

extension NestedErrorImpl: ResponseEntityHolder
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
