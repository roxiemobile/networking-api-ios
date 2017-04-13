// ----------------------------------------------------------------------------
//
//  VoidConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

open class VoidConverter: AbstractCallResultConverter<Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) -> ResponseEntity<To> {
        return BasicResponseEntityBuilder<Void>(entity: entity, body: ()).build()
    }

    override open func supportedMediaTypes() -> [MediaType] {
        return VoidConverter.SupportedMediaTypes
    }

// MARK: - Constants

    fileprivate static let SupportedMediaTypes = [MediaType.All]

}

// ----------------------------------------------------------------------------
