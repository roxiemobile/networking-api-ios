// ----------------------------------------------------------------------------
//
//  RestApiClient.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public final class RestApiClient
{
// MARK: - Construction

    private init(builder: RestApiClientBuilder)
    {
        // Init instance variables
        self.options = builder.options
    }

// MARK: - Functions

    public func get(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.GET, entity: entity)
    }

    public func post(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.POST, entity: entity)
    }

    public func put(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.PUT, entity: entity)
    }

    public func patch(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.PATCH, entity: entity)
    }

    public func delete(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.DELETE, entity: entity)
    }

    public func head(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.HEAD, entity: entity)
    }

    public func options(entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.OPTIONS, entity: entity)
    }

// MARK: - Private Functions

    private func execute(method: Alamofire.Method, entity: RequestEntity<HttpBody>) -> HttpResult
    {
        let result: HttpResult
        let cookieStore = BasicHttpCookieStore(cookies: entity.cookies)

        // Create HTTP request
        let urlRequest = newRequest(method, entity: entity)

        do {
            // Execute HTTP request
            var response = try executeWithAllInterceptors(urlRequest, cookieStore: cookieStore)

            // Follow up redirects
            while let redirectRequest = response.redirectRequest {
                response = try executeWithNetworkInterceptors(redirectRequest, cookieStore: cookieStore)
            }

            // Handle response
            result = HttpResult.Success(handleHttpResponse(response, cookieStore))
        }
        catch let error as HttpResponseError
        {
            // Handle interrupted HTTP requests
            result = HttpResult.Success(handleHttpResponse(error.httpResponse, cookieStore))
        }
        catch let error
        {
            // Handle any other errors
            result = HttpResult.Failure(error)
        }

        // Done
        return result
    }

    private func executeWithAllInterceptors(urlRequest: NSURLRequest, cookieStore: HttpCookieStore) throws -> HttpResponse
    {
        var interceptors: [Interceptor] = []

        interceptors.appendContentsOf(self.options.interceptors)
        interceptors.appendContentsOf(self.options.networkInterceptors)
        interceptors.append(newCallServerInterceptor(cookieStore))

        return try execute(urlRequest, withInterceptors: interceptors, cookieStore: cookieStore)
    }

    private func executeWithNetworkInterceptors(urlRequest: NSURLRequest, cookieStore: HttpCookieStore) throws -> HttpResponse
    {
        var interceptors: [Interceptor] = []

        interceptors.appendContentsOf(self.options.networkInterceptors)
        interceptors.append(newCallServerInterceptor(cookieStore))

        return try execute(urlRequest, withInterceptors: interceptors, cookieStore: cookieStore)
    }

    private func execute(urlRequest: NSURLRequest, withInterceptors interceptors: [Interceptor], cookieStore: HttpCookieStore) throws -> HttpResponse
    {
        // Create first chain element
        let chain = InterceptorChain(interceptors: interceptors, index: 0, request: urlRequest)

        // Start executing interceptors chain
        return try chain.proceed(urlRequest)
    }

    private func newCallServerInterceptor(cookieStore: HttpCookieStore) -> CallServerInterceptor
    {
        return CallServerInterceptorBuilder()
                .cookieStore(cookieStore)
                .connectTimeout(self.options.connectionTimeout)
                .requestTimeout(self.options.requestTimeout)
                .build()
    }

    private func newRequest(method: Alamofire.Method, entity: RequestEntity<HttpBody>) -> NSURLRequest
    {
        // Build HTTP request
        let request = URLRequest(method, entity.url!, headers: entity.headers?.allHeaderFields)

        // Create HTTP request body
        if let entityBody = entity.body
        {
            request.HTTPBody = entityBody.body
            request.setValue(entityBody.mediaType?.description, forHTTPHeaderField: HttpHeaders.Header.ContentType)
        }

        // Done
        return request
    }

    private func handleHttpResponse(httpResponse: HttpResponse, _ cookieStore: HttpCookieStore) -> ResponseEntity<NSData>
    {
        var statusCode = HttpStatus.InternalServerError
        var headers = [String: String]()

        // Get HTTP headers
        for (key, value) in httpResponse.response.allHeaderFields {
            if let key = key as? String, let value = value as? String {
                headers[key] = value
            }
        }

        // Get status code
        if let httpStatus = HttpStatus.valueOf(httpResponse.response.statusCode) {
            statusCode = httpStatus
        }

        // Create response entity
        let httpHeaders = HttpHeaders(headers)
        let entityBuilder = BasicResponseEntityBuilder<NSData>()
                .url(httpResponse.response.URL)
                .headers(httpHeaders)
                .status(statusCode)
                // @see https://tools.ietf.org/html/rfc7231#section-3.1.1.5
                .mediaType(MediaType.ApplicationOctetStream)
                .cookies(cookieStore.cookies)

        if let responseBody = httpResponse.body {
            entityBuilder.body(responseBody)

            if let contentType = httpHeaders.contentType {
                entityBuilder.mediaType(contentType)
            }
        }

        // Done
        return entityBuilder.build()
    }

    private func URLRequest(method: Alamofire.Method, _ URLString: URLStringConvertible, headers: [String: String]? = nil) -> NSMutableURLRequest
    {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
        mutableURLRequest.HTTPMethod = method.rawValue

        if let headers = headers {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }

        return mutableURLRequest
    }

// MARK: - Inner Types

    private struct Options
    {
        private var connectionTimeout = NetworkConfig.Timeout.Connection
        private var requestTimeout = NetworkConfig.Timeout.Request

        private var interceptors: [Interceptor] = []
        private var networkInterceptors: [Interceptor] = []
    }

// MARK: - Variables

    private let options: Options

}

// ----------------------------------------------------------------------------

public class RestApiClientBuilder
{
// MARK: - Functions

    public func connectTimeout(timeout: NSTimeInterval) -> Self
    {
        Require.isTrue(timeout >= 0, "timeout < 0")
        self.options.connectionTimeout = timeout
        return self
    }

    public func requestTimeout(timeout: NSTimeInterval) -> Self
    {
        Require.isTrue(timeout >= 0, "timeout < 0")
        self.options.requestTimeout = timeout
        return self
    }

    public func interceptors(interceptors: [Interceptor]) -> Self
    {
        self.options.interceptors = interceptors
        return self
    }

    public func networkInterceptors(networkInterceptors: [Interceptor]) -> Self
    {
        self.options.networkInterceptors = networkInterceptors
        return self
    }

    public func build() -> RestApiClient {
        return RestApiClient(builder: self)
    }

// MARK: - Variables

    private var options = RestApiClient.Options()

}

// ----------------------------------------------------------------------------
