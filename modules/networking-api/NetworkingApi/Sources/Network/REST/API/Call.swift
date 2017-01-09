// ----------------------------------------------------------------------------
//
//  Call.swift
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

public class Call<T>: AbstractClass
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Properties

    public func getTag() -> String {
        raiseAbstractMethodException()
    }

    public func getRequestEntity() -> RequestEntity<T> {
        raiseAbstractMethodException()
    }

}

// ----------------------------------------------------------------------------
