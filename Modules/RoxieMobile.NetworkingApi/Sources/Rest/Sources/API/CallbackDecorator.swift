// ----------------------------------------------------------------------------
//
//  CallbackDecorator.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class CallbackDecorator<Ti, To>: Callback<Ti, To> {

// MARK: - Construction

    public override init() {
        self.callback = nil
    }

    public init(callback: Callback<Ti, To>) {
        self.callback = callback
    }

// MARK: - Functions

    open override func onShouldExecute(_ call: Call<Ti>) -> Bool {

        guard let callback = self.callback else {
            return true
        }
        return callback.onShouldExecute(call)
    }

    open override func onSuccess(_ call: Call<Ti>, entity: ResponseEntity<To>) {
        self.callback?.onSuccess(call, entity: entity)
    }

    open override func onFailure(_ call: Call<Ti>, error: RestApiError) {
        self.callback?.onFailure(call, error: error)
    }

    open override func onCancel(_ call: Call<Ti>) {
        self.callback?.onCancel(call)
    }

// MARK: - Variables

    fileprivate let callback: Callback<Ti, To>?
}
