// ----------------------------------------------------------------------------
//
//  CallbackDecorator.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class CallbackDecorator<Ti, To>: Callback<Ti, To>
{
// MARK: - Construction

    public override init() {
        // Init instance variables
        self.callback = nil
    }

    public init(callback: Callback<Ti, To>)
    {
        // Init instance variables
        self.callback = callback
    }

// MARK: - Functions

    public override func onShouldExecute(call: Call<Ti>) -> Bool
    {
        guard let callback = self.callback else {
            return true
        }

        return callback.onShouldExecute(call)
    }

    public override func onResponse(call: Call<Ti>, entity: ResponseEntity<To>) {
        self.callback?.onResponse(call, entity: entity)
    }

    public override func onFailure(call: Call<Ti>, error: RestApiError) {
        self.callback?.onFailure(call, error: error)
    }

    public override func onCancel(call: Call<Ti>) {
        self.callback?.onCancel(call)
    }

// MARK: - Variables

    private let callback: Callback<Ti, To>?

}

// ----------------------------------------------------------------------------
