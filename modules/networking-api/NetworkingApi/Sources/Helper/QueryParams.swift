// ----------------------------------------------------------------------------
//
//  QueryParams.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class QueryParams: DictionaryLiteralConvertible
{
// MARK: - Construction

    public required init(dictionaryLiteral elements: (String, String)...)
    {
        for (key, value) in elements {
            add(key, value)
        }
    }

// MARK: - Properties

    var items: [String: [String]] = [:]

    public var isEmpty: Bool {
        return self.items.isEmpty
    }

// MARK: - Functions

    public func add(key: String, _ value: String) {
        self.items[key] = ((self.items[key] ?? []) + [value])
    }

    public func get(key: String) -> [String]? {
        return self.items[key]
    }

    public func remove(key: String) {
        self.items[key] = nil
    }

// MARK: - Inner Types

    public typealias Key = String

    public typealias Value = String

}

// ----------------------------------------------------------------------------
