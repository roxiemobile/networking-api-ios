// ----------------------------------------------------------------------------
//
//  RedirectHandler.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public protocol RedirectHandler: class
{
// MARK: - Functions

    func onShouldPerformHttpRedirection(response: NSHTTPURLResponse, newRequest: NSURLRequest) -> Bool

}

// ----------------------------------------------------------------------------
