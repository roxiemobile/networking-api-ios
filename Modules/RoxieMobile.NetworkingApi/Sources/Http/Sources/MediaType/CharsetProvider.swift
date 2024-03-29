// ----------------------------------------------------------------------------
//
//  CharsetProvider.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsConcurrent

// ----------------------------------------------------------------------------

// NOTE: Abstract class
class CharsetProvider {

// MARK: - Construction

    init(aliases: [String: String], classes: [String: NSObject.Type]) {
        self.aliases = aliases
        self.classes = classes
        self.cache = [:]
    }

// MARK: - Functions

    final func charsetForName(_ charsetName: String) -> Charset? {
        var charset: Charset?

        // Search for Charset by its name
        unowned let instance = self
        synchronized(self) {
            charset = instance.lookup(charsetName)
        }

        // Done
        return charset
    }

// MARK: - Private Functions

    fileprivate func lookup(_ charsetName: String) -> Charset? {

        let name = canonicalize(charsetName.lowercased())
        var charset: Charset?

        // Check cache first
        if let cs = self.cache[name] {
            charset = cs
        }
        // Do we even support this charset?
        else if let clazz = self.classes[name], let object = clazz.init() as? Charset {
            charset = object
            self.cache[name] = charset
        }

        // Done
        return charset
    }

    fileprivate func canonicalize(_ csn: String) -> String {
        return self.aliases[csn] ?? csn
    }

// MARK: - Variables

    // Maps alias names to canonical names
    fileprivate let aliases: [String: String]

    // Maps canonical names to class names
    fileprivate let classes: [String: NSObject.Type]

    // Maps canonical names to cached instances
    fileprivate var cache: [String: Charset]
}
