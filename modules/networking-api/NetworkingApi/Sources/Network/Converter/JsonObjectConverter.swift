// ----------------------------------------------------------------------------
//
//  JsonObjectConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons
import SwiftyJSON

// ----------------------------------------------------------------------------

open class JsonObjectConverter: AbstractCallResultConverter<JsonObject>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: JsonObject?

        if let body = entity.body, !(body.isEmpty)
        {
            // Try to parse response as JSON string
            var error: NSError?
            let json = JSON(data: body, options: .allowFragments, error: &error)
            if let error = error {
                throw ConversionError(entity: entity, cause: error)
            }

            // Try to parse ParcelableModel
            if let jsonObject = (json.object as? JsonObject) {
                newBody = jsonObject
            }
            else {
                throw ConversionError(entity: entity)
            }
        }

        // Create new response entity
        newEntity = BasicResponseEntityBuilder(entity: entity, body: newBody).build()
        return newEntity
    }

    override open func supportedMediaTypes() -> [MediaType] {
        return JsonObjectConverter.SupportedMediaTypes
    }

// MARK: - Constants

    fileprivate static let SupportedMediaTypes = [MediaType.ApplicationJson]

}

// ----------------------------------------------------------------------------
