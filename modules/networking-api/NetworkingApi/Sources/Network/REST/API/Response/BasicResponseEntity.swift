// ----------------------------------------------------------------------------
//
//  BasicResponseEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class BasicResponseEntity<T>: ResponseEntity<T>
{
// MARK: - Construction

    init(builder: BasicResponseEntityBuilder<T>)
    {
        // Parent processing
        super.init(
            url: builder.url,
            headers: builder.headers,
            cookies: builder.cookies,
            body: builder.body,
            status: builder.status,
            mediaType: builder.mediaType
        )
    }

}

// ----------------------------------------------------------------------------

public class BasicResponseEntityBuilder<T>: BasicRequestEntityBuilder<T>
{
// MARK: - Construction

    override init() {
        super.init()
    }

    init(entity: ResponseEntity<T>)
    {
        // Init instance variables
        self.status = entity.status
        self.mediaType = entity.mediaType

        // Parent processing
        super.init(entity: entity)
    }

    init<Ti>(entity: ResponseEntity<Ti>, body: T?)
    {
        // Init instance variables
        self.status = entity.status
        self.mediaType = entity.mediaType

        // Parent processing
        super.init(entity: entity, body: body)
    }

// MARK: - Properties

    private(set) var status: HttpStatus?

    private(set) var mediaType: MediaType?

// MARK: - Functions

    public func status(status: HttpStatus?) -> Self {
        self.status = status
        return self
    }

    public func mediaType(mediaType: MediaType?) -> Self {
        self.mediaType = mediaType
        return self
    }

    public func build() -> BasicResponseEntity<T> {
        return BasicResponseEntity(builder: self)
    }

}

// ----------------------------------------------------------------------------
