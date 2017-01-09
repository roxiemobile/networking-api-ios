// ----------------------------------------------------------------------------
//
//  Task.swift
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

public class Task<Ti, To>: Call<Ti>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public func execute(callback: Callback<Ti, To>?) {
        raiseAbstractMethodException()
    }

    public func enqueue(callback: Callback<Ti, To>?, callbackOnUiThread: Bool) -> Cancellable {
        raiseAbstractMethodException()
    }

    public func clone() -> Task<Ti, To> {
        raiseAbstractMethodException()
    }

}

// ----------------------------------------------------------------------------
