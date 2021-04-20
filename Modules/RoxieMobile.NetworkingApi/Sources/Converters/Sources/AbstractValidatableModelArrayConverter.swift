// ----------------------------------------------------------------------------
//
//  AbstractValidatableModelArrayConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiRest
import SwiftCommonsData
import SwiftyJSON

// ----------------------------------------------------------------------------

open class AbstractValidatableModelArrayConverter<T: ValidatableModel>: AbstractCallResultConverter<[T]> {

// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        var newEntity: ResponseEntity<To>
        var newBody: [T]?

        if let body = entity.body, body.isNotEmpty {
            do {
                // Try to parse response body as JSON array
                if let jsonArray = try JSON(data: body, options: .allowFragments).object as? JsonArray {

                    newBody = try jsonArray.enumerated().map { (index, element) in
                        if let jsonObject = element as? JsonObject {
                            return try T.init(from: jsonObject)
                        }
                        else {
                            let errorMessage = "Failed to convert element of array[\(index)] to JSON object."
                            throw JsonSyntaxError(reason: errorMessage)
                        }
                    }
                }
                else {
                    throw JsonSyntaxError(reason: "Failed to convert response body to JSON array.")
                }
            }
            catch {
                throw ConversionError(entity: entity, cause: error)
            }
        }

        // Create response entity
        newEntity = BasicResponseEntityBuilder(entity: entity, body: newBody).build()
        return newEntity
    }
}
