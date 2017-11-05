// ----------------------------------------------------------------------------
//
//  ImageConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import NetworkingApi
import UIKit

// ----------------------------------------------------------------------------

open class ImageConverter: AbstractCallResultConverter<UIImage>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: UIImage?

        if let body = entity.body, !(body.isEmpty)
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

    override open func supportedMediaTypes() -> [MediaType] {
        return ImageConverter.SupportedMediaTypes
    }

// MARK: - Constants

    fileprivate static let SupportedMediaTypes = [MediaType.ImageJpeg, MediaType.ImagePng]

}

// ----------------------------------------------------------------------------
