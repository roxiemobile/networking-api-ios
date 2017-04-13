// ----------------------------------------------------------------------------
//
//  StringConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

open class StringConverter: AbstractCallResultConverter<String>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To>
    {
        var newEntity: ResponseEntity<To>
        var newBody: String?

        // Convert raw data to string
        if let body = entity.body, !(body.isEmpty)
        {
            if let encoding = EncodingProvider.encodingForCharset(entity.headers?.contentType?.charset ?? Inner.DefaultCharset)
            {
                if let string = NSString(data: body, encoding: encoding) as? String {
                    newBody = string
                }
                else {
                    throw ConversionError(entity: entity)
                }
            }
        }

        // Create new response entity
        newEntity = BasicResponseEntityBuilder(entity: entity, body: newBody).build()
        return newEntity
    }

    override open func supportedMediaTypes() -> [MediaType] {
        return StringConverter.SupportedMediaTypes
    }

// MARK: - Constants

    fileprivate struct Inner {
        static let DefaultCharset = Charset.forName("ISO-8859-1")
    }

    fileprivate static let SupportedMediaTypes = [MediaType.All]

}

// ----------------------------------------------------------------------------
