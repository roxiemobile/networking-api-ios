// ----------------------------------------------------------------------------
//
//  TaskBuilder.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!

// ----------------------------------------------------------------------------

public class TaskBuilder<Ti, To>: AbstractClass
{
// MARK: - Properties

    public func getTag() -> String {
        raiseAbstractMethodException()
    }

    public func getRequestEntity() -> RequestEntity<Ti> {
        raiseAbstractMethodException()
    }

// MARK: - Functions

    public func build() -> Task<Ti, To> {
        raiseAbstractMethodException()
    }

}

// ----------------------------------------------------------------------------
