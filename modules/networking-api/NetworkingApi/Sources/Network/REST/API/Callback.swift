// ----------------------------------------------------------------------------
//
//  Callback.swift
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

public class Callback<Ti, To>
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Functions

    public func onShouldExecute(call: Call<Ti>) -> Bool {
        mdc_abstractFunction()
    }

    public func onResponse(call: Call<Ti>, entity: ResponseEntity<To>) {
        mdc_abstractFunction()
    }

    public func onFailure(call: Call<Ti>, error: RestApiError) {
        mdc_abstractFunction()
    }

    public func onCancel(call: Call<Ti>) {
        mdc_abstractFunction()
    }

}

// ----------------------------------------------------------------------------
