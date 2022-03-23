// ----------------------------------------------------------------------------
//
//  Cancellable.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public protocol Cancellable: AnyObject {

// MARK: - Functions

    @discardableResult func cancel() -> Bool
}
