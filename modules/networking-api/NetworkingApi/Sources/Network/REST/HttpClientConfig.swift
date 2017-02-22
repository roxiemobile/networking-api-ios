// ----------------------------------------------------------------------------
//
//  HttpClientConfig.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol HttpClientConfig
{
// MARK: - Methods

    /**
     * TODO
     */
    func connectTimeout() -> NSTimeInterval

    /**
     * TODO
     */
    func readTimeout() -> NSTimeInterval

// TODO: - Add interceptors

}

// ----------------------------------------------------------------------------
