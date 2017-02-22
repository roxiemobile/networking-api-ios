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

public class Callback<Ti, To>: AbstractClass
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Functions

    public func onShouldExecute(call: Call<Ti>) -> Bool {
        raiseAbstractMethodException()
    }

    public func onSuccess(call: Call<Ti>, entity: ResponseEntity<To>) {
        raiseAbstractMethodException()
    }

    public func onFailure(call: Call<Ti>, error: RestApiError) {
        raiseAbstractMethodException()
    }

    public func onCancel(call: Call<Ti>) {
        raiseAbstractMethodException()
    }

}

// ----------------------------------------------------------------------------
