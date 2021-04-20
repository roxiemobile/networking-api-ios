// ----------------------------------------------------------------------------
//
//  VoidBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp

// ----------------------------------------------------------------------------

open class VoidBody: HttpBody {

// MARK: - Properties

    open var mediaType: MediaType? {
        return nil
    }

    open var body: Data? {
        return nil
    }
}
