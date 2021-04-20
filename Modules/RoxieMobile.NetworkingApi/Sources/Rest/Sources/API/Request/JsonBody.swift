// ----------------------------------------------------------------------------
//
//  JsonBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp
import SwiftCommonsData
import SwiftyJSON

// ----------------------------------------------------------------------------

open class JsonBody: HttpBody {

// MARK: - Construction

    public init(body: JsonElement?) {
        self.jsonBody = body
    }

// MARK: - Properties

    open var mediaType: MediaType? {
        return JsonBody.MediaTypeJson
    }

    open var body: Data? {
        guard let jsonBody = self.jsonBody else {
            return nil
        }
        return try? JSON(jsonBody).rawData()
    }

// MARK: - Constants

    fileprivate static let MediaTypeJson =
        MediaType.valueOf(MediaType.ApplicationJsonValue + "; charset=" + HttpKeys.EncodingName.UTF_8)

// MARK: - Variables

    fileprivate let jsonBody: JsonElement?
}
