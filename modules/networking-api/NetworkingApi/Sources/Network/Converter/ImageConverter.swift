// ----------------------------------------------------------------------------
//
//  ImageConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

public class ImageConverter: AbstractCallResultConverter<UIImage>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    public override func convert(entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: UIImage?

        if let body = entity.body where !(body.isEmpty)
        {
            if let image = UIImage(data: body) {
                newBody = image
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
        return ImageConverter.SupportedMediaTypes
    }

// MARK: - Constants

    private static let SupportedMediaTypes = [MediaType.ApplicationJson, MediaType.ApplicationVndEkassirJson]

}

// ----------------------------------------------------------------------------
