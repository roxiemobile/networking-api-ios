// ----------------------------------------------------------------------------
//
//  NestedError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public protocol NestedError: ErrorType, CustomStringConvertible, CustomDebugStringConvertible
{
// MARK: - Properties

    var cause: ErrorType? { get }

}

// ----------------------------------------------------------------------------

extension NestedError
{
// MARK: - Properties

    public var description: String
    {
        var result = typeName(self)

        if let cause = self.cause
        {
            result += "\nСaused by error: "

            if let description = (cause as? CustomStringConvertible)?.description.trim() where description.isNotEmpty {
                result += description
            }
            else
            if let description = (cause as? CustomDebugStringConvertible)?.debugDescription.trim() where description.isNotEmpty {
                result += description
            }
            else {
                result += typeName(cause)
            }
        }

        return result
    }

    public var debugDescription: String {
        return self.description
    }

}

// ----------------------------------------------------------------------------
