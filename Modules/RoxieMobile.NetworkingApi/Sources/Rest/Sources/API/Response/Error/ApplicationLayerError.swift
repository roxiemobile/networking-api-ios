// ----------------------------------------------------------------------------
//
//  ApplicationLayerError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

open class ApplicationLayerError: AbstractRestApiError {

// MARK: - Properties

    open override var type: RestApiErrorType {
        return .applicationLayer
    }
}
