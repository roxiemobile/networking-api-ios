// ----------------------------------------------------------------------------
//
//  Call.swift
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

open class Call<T>: AbstractClass {

// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Properties

    open func getTag() -> String {
        raiseAbstractMethodException()
    }

    open func getRequestEntity() -> RequestEntity<T> {
        raiseAbstractMethodException()
    }
}
