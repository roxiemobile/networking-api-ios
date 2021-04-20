// ----------------------------------------------------------------------------
//
//  CallResultConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

public protocol CallResultConverter {

// MARK: - Functions

    /**
    * Converts result from one format to another.
    */
    func convert(_ result: CallResult<Ti>) -> CallResult<To>

    /**
    * Converts response entity from one format to another.
    */
    func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>

// MARK: - Inner Types

    associatedtype Ti

    associatedtype To
}
