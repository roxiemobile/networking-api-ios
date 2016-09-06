// ----------------------------------------------------------------------------
//
//  QueryStringPair.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

class QueryStringPair
{
// MARK: - Construction

    init(field: AnyObject?, value: AnyObject?)
    {
        // Init instance variables
        self.field = field
        self.value = value
    }

// MARK: - Properties

    let field: AnyObject?

    let value: AnyObject?

// MARK: - Functions

    func URLEncodedString(encoding: UInt = NSUTF8StringEncoding) -> String
    {
        var result = ""

        // Append "key"
        if !(self.field is NSNull), let subString = self.field?.description.trimmed() where !subString.isEmpty {
            result += subString.escapeString(encoding)
        }

        // Append "value"
        if !(self.value is NSNull), let subString = self.value?.description.trimmed() where !subString.isEmpty {
            result += (result.isEmpty ? "" : "=") + subString.escapeString(encoding)
        }

        // Done
        return result
    }

}

// ----------------------------------------------------------------------------
