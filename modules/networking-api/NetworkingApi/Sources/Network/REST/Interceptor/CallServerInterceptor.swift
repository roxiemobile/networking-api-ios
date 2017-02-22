// ----------------------------------------------------------------------------
//
//  CallServerInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

class CallServerInterceptor: Interceptor
{
// MARK: - Construction

    private init(builder: CallServerInterceptorBuilder)
    {
        // Init instance variables
        self.options = builder.options
    }

// MARK: - Functions

    func intercept(chain: InterceptorChain) throws -> HttpResponse {
        return try performRequest(chain.request)
    }

// MARK: - Private Functions

    private func performRequest(urlRequest: NSURLRequest) throws -> HttpResponse
    {
        var httpResponse: HttpResponse!
        var httpError: ErrorType?

        // Create session configuration
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()

        config.HTTPAdditionalHeaders = [:]
        config.HTTPCookieStorage = (self.options.cookieStore as? NSHTTPCookieStorage)
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
                // iOS 8.1 uses "Content-Type" header from original request after redirect that may leads to 415 Unsupported Media Type error
                // HACK: Remove "Content-Type" header from new request
                let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
                mutableRequest.setValue("", forHTTPHeaderField: HttpHeaders.Header.ContentType)

                httpResponse = HttpResponse(response: response, redirectRequest: mutableRequest)

                // Refuse all redirects
                return nil
            }
        }

        // Request data from the server
        request.resume()

        // Add queue for getting of response
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)

        // Handle response
        request.response(queue: queue) { request, response, body, error in
            if let redirectHttpResponse = httpResponse
            {
                // Append body to response
                httpResponse = redirectHttpResponse.copy(body: body)
            }
            else {
                // Handle request errors
                if let error = error
                {
                    httpError = error
                }
                else
                // Handle HTTP response
                if let response = response
                {
                    httpResponse = HttpResponse(response: response, body: body)
                }
                else {
                    rxm_fatalError("(response == nil) && (error == nil)")
                }
            }

            // Release a waiting thread
            dispatch_semaphore_signal(semaphore)
        }

        // Waiting for response
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

        // Throw HTTP error if needed
        if let httpError = httpError {
            throw httpError
        }

        // Done
        return httpResponse
    }

// MARK: - Inner Types

    private struct Options
    {
        private var cookieStore: HttpCookieStore?
        private var connectionTimeout = NetworkConfig.Timeout.Connection
        private var requestTimeout = NetworkConfig.Timeout.Request
    }

// MARK: - Variables

    private let options: Options

}

// ----------------------------------------------------------------------------

class CallServerInterceptorBuilder
{
// MARK: - Functions

    func cookieStore(cookieStore: HttpCookieStore?) -> Self
    {
        self.options.cookieStore = cookieStore
        return self
    }

    func connectTimeout(timeout: NSTimeInterval) -> Self
    {
        Expect.isTrue(timeout >= 0, "timeout < 0")
        self.options.connectionTimeout = timeout
        return self
    }

    func requestTimeout(timeout: NSTimeInterval) -> Self
    {
        Expect.isTrue(timeout >= 0, "timeout < 0")
        self.options.requestTimeout = timeout
        return self
    }

    func build() -> CallServerInterceptor {
        return CallServerInterceptor(builder: self)
    }

// MARK: - Variables

    private var options = CallServerInterceptor.Options()

}

// ----------------------------------------------------------------------------
