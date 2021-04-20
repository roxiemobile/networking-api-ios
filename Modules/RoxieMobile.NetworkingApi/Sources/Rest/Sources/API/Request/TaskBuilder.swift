// ----------------------------------------------------------------------------
//
//  TaskBuilder.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsLang

// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!

// ----------------------------------------------------------------------------

open class TaskBuilder<Ti, To>: AbstractClass {

// MARK: - Properties

    open func getTag() -> String {
        raiseAbstractMethodException()
    }

    open func getRequestEntity() -> RequestEntity<Ti> {
        raiseAbstractMethodException()
    }

// MARK: - Functions

    open func build() -> Task<Ti, To> {
        raiseAbstractMethodException()
    }
}
