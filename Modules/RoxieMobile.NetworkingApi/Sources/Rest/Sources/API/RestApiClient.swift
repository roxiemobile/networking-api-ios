// ----------------------------------------------------------------------------
//
//  RestApiClient.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation
import NetworkingApiHttp
import SwiftCommonsDiagnostics
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public final class RestApiClient {

// MARK: - Construction

    fileprivate init(builder: RestApiClientBuilder) {
        _httpClientConfig = builder.httpClientConfig ?? DefaultHttpClientConfig.shared
    }

// MARK: - Functions

    public func get(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.get, entity: entity)
    }

    public func post(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.post, entity: entity)
    }

    public func put(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.put, entity: entity)
    }

    public func patch(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.patch, entity: entity)
    }

    public func delete(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.delete, entity: entity)
    }

    public func head(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.head, entity: entity)
    }

    public func options(_ entity: RequestEntity<HttpBody>) -> HttpResult {
        return execute(.options, entity: entity)
    }

// MARK: - Private Functions

    fileprivate func execute(_ method: HTTPMethod, entity: RequestEntity<HttpBody>) -> HttpResult {

        let result: HttpResult
        let cookieStorage = entity.cookieStorage

        // Create HTTP request
        let urlRequest = createRequest(method, entity: entity)

        do {
            // Execute HTTP request
            var response = try executeWithAllInterceptors(urlRequest, cookieStorage: cookieStorage)

            // Follow up redirects
            while let redirectRequest = response.redirectRequest {
                response = try executeWithNetworkInterceptors(redirectRequest, cookieStorage: cookieStorage)
            }

            // Handle response
            result = HttpResult.success(handleHttpResponse(response, cookieStorage))
        }
        catch let error as HttpResponseError {
            // Handle interrupted HTTP requests
            result = HttpResult.success(handleHttpResponse(error.httpResponse, cookieStorage))
        }
        catch let error {
            // Handle any other errors
            result = HttpResult.failure(error)
        }

        // Done
        return result
    }

    fileprivate func executeWithAllInterceptors(
        _ urlRequest: URLRequest,
        cookieStorage: HTTPCookieStorage
    ) throws -> HttpResponse {

        var interceptors: [Interceptor] = []

        interceptors.append(contentsOf: _httpClientConfig.interceptors ?? [])
        interceptors.append(contentsOf: _httpClientConfig.networkInterceptors ?? [])
        interceptors.append(createCallServerInterceptor(cookieStorage))

        return try execute(urlRequest, withInterceptors: interceptors, cookieStorage: cookieStorage)
    }

    fileprivate func executeWithNetworkInterceptors(
        _ urlRequest: URLRequest,
        cookieStorage: HTTPCookieStorage
    ) throws -> HttpResponse {

        var interceptors: [Interceptor] = []

        interceptors.append(contentsOf: _httpClientConfig.networkInterceptors ?? [])
        interceptors.append(createCallServerInterceptor(cookieStorage))

        return try execute(urlRequest, withInterceptors: interceptors, cookieStorage: cookieStorage)
    }

    fileprivate func execute(
        _ urlRequest: URLRequest,
        withInterceptors interceptors: [Interceptor],
        cookieStorage: HTTPCookieStorage
    ) throws -> HttpResponse {

        // Create first chain element
        let chain = InterceptorChain(interceptors: interceptors, index: 0, request: urlRequest)

        // Start executing interceptors chain
        return try chain.proceed(urlRequest)
    }

    fileprivate func createCallServerInterceptor(_ cookieStorage: HTTPCookieStorage) -> CallServerInterceptor {

        let requestTimeoutConfig = _httpClientConfig.requestTimeoutConfig
            ?? DefaultRequestTimeoutConfig.shared

        return CallServerInterceptorBuilder()
            .connectionTimeout(requestTimeoutConfig.connectionTimeout)
            .readTimeout(requestTimeoutConfig.readTimeout)
            .tlsConfig(_httpClientConfig.tlsConfig)
            .cookieStorage(cookieStorage)
            .build()
    }

    fileprivate func createRequest(_ method: HTTPMethod, entity: RequestEntity<HttpBody>) -> URLRequest {

        // Build HTTP request
        var request = URLRequestForMethod(method, entity.url!, headers: entity.headers?.allHeaderFields)

        // Create HTTP request body
        if let entityBody = entity.body {

            request.httpBody = entityBody.body
            request.setValue(entityBody.mediaType?.description, forHTTPHeaderField: HttpHeaders.Header.ContentType)
        }

        // Done
        return request
    }

    fileprivate func handleHttpResponse(
        _ httpResponse: HttpResponse,
        _ cookieStorage: HTTPCookieStorage
    ) -> ResponseEntity<Data> {

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
        let entityBuilder = BasicResponseEntityBuilder<Data>()
            .url(httpResponse.response.url)
            .headers(httpHeaders)
            .status(statusCode)
            // @see https://tools.ietf.org/html/rfc7231#section-3.1.1.5
            .mediaType(MediaType.ApplicationOctetStream)
            .cookieStorage(cookieStorage)

        if let responseBody = httpResponse.body {
            entityBuilder.body(responseBody)

            if let contentType = httpHeaders.contentType {
                entityBuilder.mediaType(contentType)
            }
        }

        // Done
        return entityBuilder.build()
    }

    fileprivate func URLRequestForMethod(
        _ method: HTTPMethod,
        _ URLString: URLConvertible,
        headers: [String: String]? = nil
    ) -> URLRequest {

        guard let url = try? URLString.asURL() else {
            Roxie.fatalError("Unexpected URLString")
        }

        var mutableURLRequest = URLRequest(url: url)

        mutableURLRequest.httpMethod = method.rawValue

        if let headers = headers {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }

        return mutableURLRequest
    }

// MARK: - Variables

    private let _httpClientConfig: HttpClientConfig
}

// ----------------------------------------------------------------------------

open class RestApiClientBuilder {

// MARK: - Functions

    open func httpClientConfig(_ httpClientConfig: HttpClientConfig) -> Self {
        self.httpClientConfig = httpClientConfig.clone()
        return self
    }

    open func build() -> RestApiClient {
        return RestApiClient(builder: self)
    }

// MARK: - Variables

    fileprivate var httpClientConfig: HttpClientConfig?
}
