// ----------------------------------------------------------------------------
//
//  BasicRequestEntity.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public class BasicRequestEntity<T>: RequestEntity<T>
{
// MARK: - Construction

    init(builder: BasicRequestEntityBuilder<T>)
    {
        // Parent processing
        super.init(
            url: builder.url,
            headers: builder.headers,
            cookies: builder.cookies,
            body: builder.body
        )
    }

}

// ----------------------------------------------------------------------------

public class BasicRequestEntityBuilder<T>
{
// MARK: - Construction

    public init() {
        // Do nothing
    }

    public init(entity: RequestEntity<T>)
    {
        // Init instance variables
        self.url = entity.url
        self.headers = entity.headers
        self.cookies = entity.cookies
        self.body = entity.body
    }

    public init<Ti>(entity: RequestEntity<Ti>, body: T?)
    {
        // Init instance variables
        self.url = entity.url
        self.headers = entity.headers
        self.cookies = entity.cookies
        self.body = body
    }

// MARK: - Properties

    private(set) var url: NSURL?

    private(set) var headers: HttpHeaders?

    private(set) var cookies: [HttpCookie]?

    private(set) var body: T?

// MARK: - Functions

    public func url(url: NSURL?) -> Self {
        self.url = url
        return self
    }

    public func headers(headers: HttpHeaders?) -> Self {
        self.headers = headers
        return self
    }

    public func cookies(cookies: [HttpCookie]?) -> Self {
        self.cookies = cookies
        return self
    }

    public func body(body: T?) -> Self {
        self.body = body
        return self
    }

    public func build() -> BasicRequestEntity<T> {
        return BasicRequestEntity(builder: self)
    }

}

// ----------------------------------------------------------------------------
