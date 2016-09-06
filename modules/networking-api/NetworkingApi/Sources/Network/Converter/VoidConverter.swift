// ----------------------------------------------------------------------------
//
//  VoidConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class VoidConverter: AbstractCallResultConverter<Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public override func convert(entity: ResponseEntity<Ti>) -> ResponseEntity<To> {
        return BasicResponseEntityBuilder<Void>(entity: entity, body: ()).build()
    }

    override public func supportedMediaTypes() -> [MediaType] {
        return VoidConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [MediaType.All]

}

// ----------------------------------------------------------------------------
