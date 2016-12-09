// ----------------------------------------------------------------------------
//
//  AbstractSerializableModelConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class AbstractSerializableModelConverter<T: ParcelableModel>: AbstractCallResultConverter<T>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public override func convert(entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: T?

        if let body = entity.body where !(body.isEmpty)
        {
            // Try to parse response as JSON string
            var error: NSError?
            let json = JSON(data: body, options: .AllowFragments, error: &error)
            if let error = error {
                throw ConversionError(entity: entity, cause: error)
            }

            do {
                if let jsonObject = (json.object as? JsonObject) {
                    newBody = try T.init(params: jsonObject)
                }
                else {
                    throw JsonSyntaxException("Could not transform model.")
                }
            }
            catch let exception as JsonSyntaxException {
                throw ConversionError(entity: entity, cause: exception)
            }
        }

        newEntity = BasicResponseEntityBuilder(entity: entity, body: newBody).build()
        return newEntity
    }

}

// ----------------------------------------------------------------------------
