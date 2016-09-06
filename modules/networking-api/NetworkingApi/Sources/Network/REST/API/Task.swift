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
// MARK: - Functions

    func execute(callback: Callback<Ti, To>?) {
        mdc_abstractFunction()
    }

    func enqueue(callback: Callback<Ti, To>?, callbackOnUiThread: Bool) -> Cancellable {
        mdc_abstractFunction()
    }

    func clone() -> Task<Ti, To> {
        mdc_abstractFunction()
    }

}

// ----------------------------------------------------------------------------
