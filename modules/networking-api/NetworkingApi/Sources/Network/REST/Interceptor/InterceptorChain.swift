// ----------------------------------------------------------------------------
//
//  InterceptorChain.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public class InterceptorChain
{
// MARK: - Construction

    init(interceptors: [Interceptor], index: Int, request: NSURLRequest)
    {
        // Init instance variables
        self.interceptors = interceptors
        self.index = index
        self.request = request
    }

// MARK: - Properties

    public let request: NSURLRequest

// MARK: - Functions

    public func proceed(request: NSURLRequest) throws -> HttpResponse
    {
        guard (self.index < self.interceptors.count) else {
            rxm_fatalError("Invalid intercepter index in chain.")
        }

        let next = InterceptorChain(interceptors: self.interceptors, index: (self.index + 1), request: self.request)

        let interceptor = self.interceptors[self.index]
        let result = try interceptor.intercept(next)

        return result
    }

// MARK: - Variables

    private let interceptors: [Interceptor]

    private let index: Int

}

// ----------------------------------------------------------------------------
