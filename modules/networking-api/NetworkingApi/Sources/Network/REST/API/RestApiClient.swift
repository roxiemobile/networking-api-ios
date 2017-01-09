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
        let cookieStore = BasicHttpCookieStore(cookies: entity.cookies)

        // Create HTTP request
        let request = newRequest(method, entity: entity)

        // Execute HTTP request
        return execute(request, cookieStore: cookieStore)
    }

    private func execute(urlRequest: URLRequestConvertible, cookieStore: HttpCookieStore) -> HttpResult
    {
        var result: HttpResult!

        // Create session configuration
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()

        config.HTTPAdditionalHeaders = [:]
        config.HTTPCookieStorage = (cookieStore as? NSHTTPCookieStorage)
        config.timeoutIntervalForResource = self.options.connectionTimeout
        config.timeoutIntervalForRequest  = self.options.requestTimeout

        // Issues with NSURLSession Not Sending HTTPAdditionalHeaders
        // @link https://teamtreehouse.com/forum/issues-with-nsurlsession-not-sending-httpadditionalheaders

        // Send POST request using NSURLSession
        // @link http://stackoverflow.com/a/19101084

        // How to POST NSMutableURLRequest alogn with custome header fields using Alamofire
        // @link http://stackoverflow.com/q/27025811

        // How to use Alamofire with custom headers
        // @link http://stackoverflow.com/a/26055667

        let urlRequest = urlRequest.URLRequest.mutableCopy() as! NSMutableURLRequest

        for (header, value) in config.HTTPAdditionalHeaders! {
            urlRequest.setValue(value as? String, forHTTPHeaderField: header as! String)
        }

        // Create manager
        let manager = Manager(configuration: config)
        manager.startRequestsImmediately = false

        // Create suspended request
        let request = manager.request(urlRequest)

        weak var weakSelf = self
        if let sessionDelegate = request.session.delegate as? Manager.SessionDelegate
        {
            // Handle authentication challenge
            sessionDelegate.sessionDidReceiveChallenge = { session, challenge in
                return (.PerformDefaultHandling, nil)
            }
            sessionDelegate.taskDidReceiveChallenge = { session, task, challenge in
                return (.PerformDefaultHandling, nil)
            }

            // Handle redirects
            sessionDelegate.taskWillPerformHTTPRedirection = { session, task, response, request in
                var newRequest: NSURLRequest? = request

                // Log response
                LogUtils.logResponse(response, body: nil)

                if let handler = weakSelf?.options.redirectHandler {
                    if !handler.onShouldPerformHttpRedirection(response, newRequest: request) {
                        newRequest = nil
                    }
                }

                if let request = newRequest
                {
                    // Log request
                    LogUtils.logRequest(request)

                    // iOS 8.1 uses "Content-Type" header from original request after redirect that may leads to 415 Unsupported Media Type error
                    // HACK: Remove "Content-Type" header from new request
                    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
                    mutableRequest.setValue("", forHTTPHeaderField: HttpHeaders.Header.ContentType)
                    newRequest = mutableRequest
                }

                return newRequest
            }
        }

        // Log request
        LogUtils.logRequest(urlRequest)

        // Request data from the server
        request.resume()

        // Add queue for getting of response
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)

        // Handle response
        request.response(queue: queue) { request, response, body, error in
            // Handle request errors
            if let error = error {
                result = HttpResult.Failure(error)
            }
            else
            // Handle HTTP response
            if let response = response
            {
                // Log response
                LogUtils.logResponse(response, body: body)

                if let entity = weakSelf?.handleResponse(response, body, cookieStore)
                {
                    // Create result
                    result = HttpResult.Success(entity)
                }
            }
            else {
                rxm_fatalError("(response == nil) && (error == nil)")
            }

            // Release a waiting thread
            dispatch_semaphore_signal(semaphore)
        }

        // Waiting for response
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

        // Done
        return result
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

    private func handleResponse(response: NSHTTPURLResponse, _ responseBody: NSData?, _ cookieStore: HttpCookieStore) -> ResponseEntity<NSData>
    {
        var statusCode = HttpStatus.InternalServerError
        var headers = [String: String]()

        // Get HTTP headers
        for (key, value) in response.allHeaderFields {
            if let key = key as? String, let value = value as? String {
                headers[key] = value
            }
        }

        // Get status code
        if let httpStatus = HttpStatus.valueOf(response.statusCode) {
            statusCode = httpStatus
        }

        // Create response entity
        let httpHeaders = HttpHeaders(headers)
        let entityBuilder = BasicResponseEntityBuilder<NSData>()
                .url(response.URL)
                .headers(httpHeaders)
                .status(statusCode)
                // @see https://tools.ietf.org/html/rfc7231#section-3.1.1.5
                .mediaType(MediaType.ApplicationOctetStream)
                .cookies(cookieStore.cookies)

        if let responseBody = responseBody {
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
        private var redirectHandler: RedirectHandler?
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
        Expect.isTrue(timeout >= 0, "timeout < 0")
        self.options.connectionTimeout = timeout
        return self
    }

    public func requestTimeout(timeout: NSTimeInterval) -> Self
    {
        Expect.isTrue(timeout >= 0, "timeout < 0")
        self.options.requestTimeout = timeout
        return self
    }

    public func redirectHandler(redirectHandler: RedirectHandler?) -> Self
    {
        self.options.redirectHandler = redirectHandler
        return self
    }

    public func build() -> RestApiClient {
        return RestApiClient(builder: self)
    }

// MARK: - Variables

    private var options = RestApiClient.Options()

}

// ----------------------------------------------------------------------------
