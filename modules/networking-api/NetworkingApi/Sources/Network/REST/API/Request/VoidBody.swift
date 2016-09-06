// ----------------------------------------------------------------------------
//
//  VoidBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public class VoidBody: HttpBody
{
// MARK: - Properties

    public var mediaType: MediaType? {
        return nil
    }

    public var body: NSData? {
        return nil
    }

}

// ----------------------------------------------------------------------------
