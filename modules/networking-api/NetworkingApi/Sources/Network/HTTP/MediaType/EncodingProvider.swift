// ----------------------------------------------------------------------------
//
//  EncodingProvider.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class EncodingProvider: NonCreatable
{
// MARK: - Functions

    /**
     * Retrieves a encoding for the given charset.
     *
     * @param  charset
     *         The requested charset.
     *
     * @return  A encoding object for the requested charset, or NIL
     *          if the named charset is not supported by this provider.
     *
     * @throws  FatalError
     *          If no support for the named charset is available
     */
    public class func encodingForCharset(charset: Charset) -> UInt? {
        return encodingForCharsetName(charset.name)
    }

    /**
     * Retrieves a encoding for the given charset name. </p>
     *
     * @param  charsetName
     *         The name of the requested charset; may be either
     *         a canonical name or an alias.
     *
     * @return  A charset object for the named charset, or <tt>null</tt>
     *          if the named charset is not supported by this provider.
     *
     * @throws  FatalError
     *          If no support for the named charset is available
     */
    public class func encodingForCharsetName(charsetName: String) -> UInt?
    {
        var encoding: UInt?

        switch (charsetName.lowercaseString)
        {
            case Charset.US_ASCII.Const.Name:
                encoding = NSASCIIStringEncoding

            case Charset.ISO_8859_1.Const.Name:
                encoding = NSISOLatin1StringEncoding
            case Charset.ISO_8859_2.Const.Name:
                encoding = NSISOLatin2StringEncoding

            case Charset.UTF_8.Const.Name:
                encoding = NSUTF8StringEncoding

            case Charset.UTF_16.Const.Name:
                encoding = NSUTF16StringEncoding
            case Charset.UTF_16BE.Const.Name:
                encoding = NSUTF16BigEndianStringEncoding
            case Charset.UTF_16LE.Const.Name:
                encoding = NSUTF16LittleEndianStringEncoding

            case Charset.UTF_32.Const.Name:
                encoding = NSUTF32StringEncoding
            case Charset.UTF_32BE.Const.Name:
                encoding = NSUTF32BigEndianStringEncoding
            case Charset.UTF_32LE.Const.Name:
                encoding = NSUTF32LittleEndianStringEncoding

            case Charset.WINDOWS_1250.Const.Name:
                encoding = NSWindowsCP1250StringEncoding
            case Charset.WINDOWS_1251.Const.Name:
                encoding = NSWindowsCP1251StringEncoding
            case Charset.WINDOWS_1252.Const.Name:
                encoding = NSWindowsCP1252StringEncoding
            case Charset.WINDOWS_1253.Const.Name:
                encoding = NSWindowsCP1253StringEncoding
            case Charset.WINDOWS_1254.Const.Name:
                encoding = NSWindowsCP1254StringEncoding

            default:
        // Terminate application with runtime exception
                mdc_fatalError("‘\(charsetName)’ charset is not supported.")
        }

        return encoding
    }

}

// ----------------------------------------------------------------------------
