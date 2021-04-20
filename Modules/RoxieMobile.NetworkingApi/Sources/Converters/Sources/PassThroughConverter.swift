// ----------------------------------------------------------------------------
//
//  PassThroughConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class PassThroughConverter: AbstractCallResultConverter<Data> {

// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        return entity
    }

    open override func supportedMediaTypes() -> [MediaType] {
        return PassThroughConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [
        MediaType.All,
    ]
}
