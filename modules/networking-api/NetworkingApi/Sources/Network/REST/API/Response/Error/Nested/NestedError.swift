// ----------------------------------------------------------------------------
//
//  NestedError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol NestedError: Error
{
// MARK: - Properties

    var cause: Error? { get }

}

// ----------------------------------------------------------------------------
