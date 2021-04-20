// ----------------------------------------------------------------------------
//
//  MultiValueDictionary.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class MultiValueDictionary<Key: Hashable, Value> {

// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Methods

    open func add(_ value: Value, key: Key) {
        var keyValues = self.values[key] ?? []
        keyValues.append(value)
        self.values[key] = keyValues
    }

    open func get(_ key: Key) -> [Value] {
        return self.values[key] ?? []
    }

    open func remove(_ key: Key) -> [Value] {
        return self.values.removeValue(forKey: key) ?? []
    }

    /**
     * NOTE: Value must be reference-type
     */
    @discardableResult open func remove(_ key: Key, value: Value) -> Value? {
        var result: Value?

        if let index = (self.values[key]?.firstIndex { ($0 as AnyObject) === (value as AnyObject) }) {
            result = self.values[key]?.remove(at: index)
        }

        return result
    }

// MARK: - Variables

    fileprivate var values: [Key: [Value]] = [:]
}
