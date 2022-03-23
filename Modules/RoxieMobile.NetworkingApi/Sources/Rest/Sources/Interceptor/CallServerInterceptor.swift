// ----------------------------------------------------------------------------
//
//  CallServerInterceptor.swift
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

class CallServerInterceptor: Interceptor {

// MARK: - Construction

    fileprivate init(builder: CallServerInterceptorBuilder) {
        self.options = builder.options
    }

// MARK: - Functions

    func intercept(_ chain: InterceptorChain) throws -> HttpResponse {
        return try performRequest(chain.request as URLRequest)
    }

// MARK: - Private Functions

    fileprivate func performRequest(_ urlRequest: URLRequest) throws -> HttpResponse {

        var httpResponse: HttpResponse!
        var httpError: Error?

        // Create session configuration
        let config = URLSessionConfiguration.ephemeral

        config.httpAdditionalHeaders = [:]
        config.httpCookieStorage = (self.options.cookieStore as? HTTPCookieStorage)
        config.timeoutIntervalForResource = self.options.connectionTimeout
        config.timeoutIntervalForRequest = self.options.requestTimeout

        // Send POST request using NSURLSession
        // @link https://stackoverflow.com/a/19101084

        // How to POST NSMutableURLRequest alogn with custome header fields using Alamofire
        // @link https://stackoverflow.com/q/27025811

        // How to use Alamofire with custom headers
        // @link https://stackoverflow.com/a/26055667

        // taskWillPerformHTTPRedirection never called in Alamofire 5
        // @link https://stackoverflow.com/a/60822110

        // Create redirector
        let redirector = Redirector(behavior: .modify { _, request, response in
            var mutableRequest = request

            // iOS 8.1 uses "Content-Type" header from original request after redirect that may leads
            // to 415 Unsupported Media Type error.

            if (request.value(forHTTPHeaderField: HttpHeaders.Header.ContentType) != nil) {
                mutableRequest.setValue(nil, forHTTPHeaderField: HttpHeaders.Header.ContentType)
            }

            httpResponse = HttpResponse(response: response, redirectRequest: mutableRequest)

            // Refuse all redirects
            return nil
        })

        // Create session
        let session = Session(configuration: config, redirectHandler: redirector)

        // Request data from the server
        let request = session.request(urlRequest)

        // Add queue for getting of response
        let queue = DispatchQueue.global(qos: .default)

        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

        // Handle response
        request.response(queue: queue) { (dataResponse) in

            if let redirectHttpResponse = httpResponse {
                // Append body to response
                httpResponse = redirectHttpResponse.copy(body: dataResponse.data)
            }
            // Handle request errors
            else if let error = dataResponse.error {
                httpError = error
            }
            // Handle HTTP response
            else if let response = dataResponse.response {
                httpResponse = HttpResponse(response: response, body: dataResponse.data)
            }
            else {
                Roxie.fatalError("(response == nil) && (error == nil)")
            }

            // Release a waiting thread
            semaphore.signal()
        }

        // Waiting for response
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        // Throw HTTP error if needed
        if let httpError = httpError {
            throw httpError
        }

        // Done
        return httpResponse
    }

// MARK: - Inner Types

    fileprivate struct Options {
        fileprivate var cookieStore: HttpCookieStore?
        fileprivate var connectionTimeout = NetworkConfig.Timeout.Connection
        fileprivate var requestTimeout = NetworkConfig.Timeout.Request
    }

// MARK: - Variables

    fileprivate let options: Options
}

// ----------------------------------------------------------------------------

class CallServerInterceptorBuilder {

// MARK: - Functions

    func cookieStore(_ cookieStore: HttpCookieStore?) -> Self {
        self.options.cookieStore = cookieStore
        return self
    }

    func connectTimeout(_ timeout: TimeInterval) -> Self {
        Guard.greaterThanOrEqualTo(timeout, 0, "timeout < 0")
        self.options.connectionTimeout = timeout
        return self
    }

    func requestTimeout(_ timeout: TimeInterval) -> Self {
        Guard.greaterThanOrEqualTo(timeout, 0, "timeout < 0")
        self.options.requestTimeout = timeout
        return self
    }

    func build() -> CallServerInterceptor {
        return CallServerInterceptor(builder: self)
    }

// MARK: - Variables

    fileprivate var options = CallServerInterceptor.Options()
}
