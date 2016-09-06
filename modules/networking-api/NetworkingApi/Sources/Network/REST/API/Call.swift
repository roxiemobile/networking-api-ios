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

public class Call<T>
{
// MARK: - Properties

    public func getTag() -> String {
        mdc_abstractFunction()
    }

    public func getRequestEntity() -> RequestEntity<T> {
        mdc_abstractFunction()
    }

}

// ----------------------------------------------------------------------------
