// ----------------------------------------------------------------------------
//
//  HttpEntity.swift
//
//  @author     Alexander Bragin <bragin-av@roxiemobile.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class HttpEntity<T> {

// MARK: - Construction

    /// Create a new, empty {@code HttpEntity}.
    fileprivate convenience init() {
        self.init(body: nil, headers: nil)
    }

    /**
     * Create a new {@code HttpEntity} with the given body and no headers.
     * @param body the entity body
     */
    public convenience init(body: T) {
        self.init(body: body, headers: nil)
    }

    /**
     * Create a new {@code HttpEntity} with the given headers and no body.
     * @param headers the entity headers
     */
    public convenience init(headers: [String: String]) {
        self.init(body: nil, headers: headers)
    }

    /**
     * Create a new {@code HttpEntity} with the given body and headers.
     * @param body the entity body
     * @param headers the entity headers
     */
    public init(body: T?, headers: [String: String]?) {
        self.headers = HttpHeaders(headers ?? [String: String]())
        self.body = body
    }

// MARK: - Properties

    /// Returns the body of this entity.
    public let body: T?

    /// Returns the headers of this entity.
    public let headers: HttpHeaders?

// MARK: - Functions

    /// Indicates whether this entity has a body.
    open func hasBody() -> Bool {
        return (self.body != nil)
    }
}
