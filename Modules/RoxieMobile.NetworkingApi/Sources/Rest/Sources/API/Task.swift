// ----------------------------------------------------------------------------
//
//  Task.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

// FIXME: Should be generic protocol!
open class Task<Ti, To>: Call<Ti> {

// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open func execute(_ callback: Callback<Ti, To>?) {
        raiseAbstractMethodException()
    }

    @discardableResult open func enqueue(_ callback: Callback<Ti, To>?, callbackOnUiThread: Bool) -> Cancellable {
        raiseAbstractMethodException()
    }

    open func clone() -> Task<Ti, To> {
        raiseAbstractMethodException()
    }
}
