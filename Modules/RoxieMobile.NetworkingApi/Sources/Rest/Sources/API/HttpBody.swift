// ----------------------------------------------------------------------------
//
//  HttpBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp

// ----------------------------------------------------------------------------

public protocol HttpBody {

// MARK: - Properties

    var mediaType: MediaType? { get }

    var body: Data? { get }
}
