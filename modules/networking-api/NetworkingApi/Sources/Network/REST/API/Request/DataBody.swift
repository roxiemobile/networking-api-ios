// ----------------------------------------------------------------------------
//
//  DataBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public class DataBody: HttpBody
{
// MARK: - Construction

    private init(builder: DataBodyBuilder)
    {
        // Init instance variables
        self.mediaType = builder.mediaType
        self.body = builder.body
    }

// MARK: - Properties

    public let mediaType: MediaType?

    public let body: NSData?

}

// ----------------------------------------------------------------------------

public class DataBodyBuilder
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Properties

    public private(set) var mediaType: MediaType?

    public private(set) var body: NSData?

// MARK: - Functions

    public func mediaType(mediaType: MediaType?) -> Self
    {
        self.mediaType = mediaType
        return self
    }

    public func body(body: NSData?) -> Self
    {
        self.body = body
        return self
    }

    public func build() -> DataBody {
        return DataBody(builder: self)
    }

}

// ----------------------------------------------------------------------------
