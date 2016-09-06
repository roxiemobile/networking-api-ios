// ----------------------------------------------------------------------------
//
//  PassThroughConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class PassThroughConverter: AbstractCallResultConverter<NSData>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public override func convert(entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        return entity
    }

    override public func supportedMediaTypes() -> [MediaType] {
        return PassThroughConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [MediaType.All]

}

// ----------------------------------------------------------------------------
