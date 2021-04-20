// ----------------------------------------------------------------------------
//
//  VoidConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class VoidConverter: AbstractCallResultConverter<Void> {

// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) -> ResponseEntity<To> {
        return BasicResponseEntityBuilder<Void>(entity: entity, body: ()).build()
    }

    open override func supportedMediaTypes() -> [MediaType] {
        return VoidConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [
        MediaType.All,
    ]
}
