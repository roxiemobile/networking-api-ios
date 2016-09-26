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

// ----------------------------------------------------------------------------

public class JsonObjectConverter: AbstractCallResultConverter<JsonObject>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public override func convert(entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: JsonObject?

        if let body = entity.body where !(body.isEmpty)
        {
            // Try to parse response as JSON string
            var error: NSError?
            let json = JSON(data: body, options: .AllowFragments, error: &error)
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

    override public func supportedMediaTypes() -> [MediaType] {
        return JsonObjectConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [MediaType.ApplicationJson]

}

// ----------------------------------------------------------------------------
