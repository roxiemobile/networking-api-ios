// ----------------------------------------------------------------------------
//
//  ConnectionError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class ConnectionError: NestedError
{
// MARK: - Construction

    public init(cause: ErrorType?)
    {
        // Init instance variables
        self.cause = cause
    }

// MARK: - Properties

    public let cause: ErrorType?

}

// ----------------------------------------------------------------------------
