// ----------------------------------------------------------------------------
//
//  ResponseEntityHolder.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol ResponseEntityHolder
{
// MARK: - Functions

    /**
    * Returns the HTTP response entity.
    */
    func getResponseEntity() -> ResponseEntity<NSData>

    /**
    * Returns the response body as a byte array.
    */
    func getResponseBodyAsBytes() -> NSData?

    /**
    * Returns the response body as a string.
    */
    func getResponseBodyAsString() -> String?

}

// ----------------------------------------------------------------------------
