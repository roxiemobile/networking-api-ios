// ----------------------------------------------------------------------------
//
//  NetworkConfig.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class NetworkConfig: NonCreatable
{
// MARK: - Constants

    public struct Timeout
    {
        public static let Connection: NSTimeInterval = 60
        public static let Request: NSTimeInterval = 60
    }

}

// ----------------------------------------------------------------------------
