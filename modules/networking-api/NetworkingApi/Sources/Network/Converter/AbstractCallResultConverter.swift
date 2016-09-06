// ----------------------------------------------------------------------------
//
//  AbstractCallResultConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class AbstractCallResultConverter<T>: CallResultConverter
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Functions

    public func convert(result: CallResult<NSData>) -> CallResult<T>
    {
        var newResult: CallResult<T>

        // Handle call result
        switch result
        {
            case .Success(let entity):
                do {
                    try checkMediaType(entity)

                    // Convert response entity
                    let response = try convert(entity)
                    newResult = .Success(response)
                }
                catch (let cause)
                {
                    // Build new error with caught exception
                    let error = ApplicationLayerError(cause: cause)
                    newResult = .Failure(error)
                }

            case .Failure(let error):
                // Copy an original error
                newResult = .Failure(error)
        }

        // Done
        return newResult
    }

    public func convert(entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        fatalError()
    }

    public func supportedMediaTypes() -> [MediaType] {
        fatalError()
    }

// MARK: - Private Methods

    private func checkMediaType(entity: ResponseEntity<Ti>) throws
    {
        let mediaType = entity.mediaType
        var found = false

        // Search for compatible MediaType
        if let mediaType = mediaType
        {
            for type in supportedMediaTypes()
            {
                if mediaType.isCompatibleWith(type)
                {
                    found = true
                    break
                }
            }
        }

        // Throw exception if on MediaType found
        if !found {
            throw UnexpectedMediaTypeError(entity: entity)
        }
    }

// MARK: - Inner Types

    public typealias Ti = NSData

    public typealias To = T

}

// ----------------------------------------------------------------------------
