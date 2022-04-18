// ----------------------------------------------------------------------------
//
//  TlsConfig.swift
//
//  @author     Nikita Kolesnikov <kolesnikov-nv@roxiemobile.com>
//  @copyright  Copyright (c) 2022, Roxie Mobile Ltd. All rights reserved.
//  @link       https://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import Alamofire
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public protocol TlsConfig: Cloneable {

// MARK: - Properties

    var trustManager: ServerTrustManager { get }
}
