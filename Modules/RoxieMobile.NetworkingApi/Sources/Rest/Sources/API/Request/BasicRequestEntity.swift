// ----------------------------------------------------------------------------
//
//  BasicRequestEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp

// ----------------------------------------------------------------------------

open class BasicRequestEntity<T>: RequestEntity<T> {

// MARK: - Construction

    internal init(builder: BasicRequestEntityBuilder<T>) {
        super.init(
            url: builder.url,
            headers: builder.headers,
            cookieStorage: builder.cookieStorage ?? InMemoryCookieStorage(),
            body: builder.body
        )
    }
}

// ----------------------------------------------------------------------------

open class BasicRequestEntityBuilder<T> {

// MARK: - Construction

    public init() {
        // Do nothing
    }

    public init(entity: RequestEntity<T>) {
        self.url = entity.url
        self.headers = entity.headers
        self.cookieStorage = entity.cookieStorage
        self.body = entity.body
    }

    public init<Ti>(entity: RequestEntity<Ti>, body: T?) {
        self.url = entity.url
        self.headers = entity.headers
        self.cookieStorage = entity.cookieStorage
        self.body = body
    }

// MARK: - Properties

    fileprivate(set) var url: URL?

    fileprivate(set) var headers: HttpHeaders?

    fileprivate(set) var cookieStorage: HTTPCookieStorage?

    fileprivate(set) var body: T?

// MARK: - Functions

    @discardableResult open func url(_ url: URL?) -> Self {
        self.url = url
        return self
    }

    @discardableResult open func headers(_ headers: HttpHeaders?) -> Self {
        self.headers = headers
        return self
    }

    @discardableResult
    open func cookieStorage(_ cookieStorage: HTTPCookieStorage) -> Self {
        self.cookieStorage = cookieStorage
        return self
    }

    @available(*, deprecated, message: "use cookieStorage(_:) instead")
    @discardableResult open func cookies(_ cookies: [HttpCookieProtocol]?) -> Self {
        self.cookieStorage = InMemoryCookieStorage(cookies: cookies?.compactMap { HTTPCookie($0) } ?? [])
        return self
    }

    @discardableResult open func body(_ body: T?) -> Self {
        self.body = body
        return self
    }

    open func build() -> BasicRequestEntity<T> {
        return BasicRequestEntity(builder: self)
    }
}
