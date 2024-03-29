// ----------------------------------------------------------------------------
//
//  BasicResponseEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHttp

// ----------------------------------------------------------------------------

open class BasicResponseEntity<T>: ResponseEntity<T> {

// MARK: - Construction

    init(builder: BasicResponseEntityBuilder<T>) {
        super.init(
            url: builder.url,
            headers: builder.headers,
            cookieStorage: builder.cookieStorage ?? InMemoryCookieStorage(),
            body: builder.body,
            status: builder.status,
            mediaType: builder.mediaType
        )
    }
}

// ----------------------------------------------------------------------------

open class BasicResponseEntityBuilder<T>: BasicRequestEntityBuilder<T> {

// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(entity: ResponseEntity<T>) {
        self.status = entity.status
        self.mediaType = entity.mediaType

        // Parent processing
        super.init(entity: entity)
    }

    public init<Ti>(entity: ResponseEntity<Ti>, body: T?) {
        self.status = entity.status
        self.mediaType = entity.mediaType

        // Parent processing
        super.init(entity: entity, body: body)
    }

// MARK: - Properties

    fileprivate(set) var status: HttpStatus?

    fileprivate(set) var mediaType: MediaType?

// MARK: - Functions

    @discardableResult open func status(_ status: HttpStatus?) -> Self {
        self.status = status
        return self
    }

    @discardableResult open func mediaType(_ mediaType: MediaType?) -> Self {
        self.mediaType = mediaType
        return self
    }

    open func build() -> BasicResponseEntity<T> {
        return BasicResponseEntity(builder: self)
    }
}
