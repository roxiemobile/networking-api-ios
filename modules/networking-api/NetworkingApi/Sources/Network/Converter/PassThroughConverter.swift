// ----------------------------------------------------------------------------
//
//  PassThroughConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

open class PassThroughConverter: AbstractCallResultConverter<Data>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        return entity
    }

    override open func supportedMediaTypes() -> [MediaType] {
        return PassThroughConverter.SupportedMediaTypes
    }

// MARK: - Constants

    fileprivate static let SupportedMediaTypes = [MediaType.All]

}

// ----------------------------------------------------------------------------
