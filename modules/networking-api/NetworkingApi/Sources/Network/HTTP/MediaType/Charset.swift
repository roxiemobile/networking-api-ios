// ----------------------------------------------------------------------------
//
//  Charset.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public class Charset: NSObject
{
// MARK: - Construction

    /**
     * Initializes a new charset with the given canonical name and alias set.
     *
     * @param  canonicalName
     *         The canonical name of this charset
     *
     * @param  aliases
     *         An array of this charset's aliases, or null if it has no aliases
     *
     * @throws FatalError
     *         If the canonical name or any of the aliases are illegal
     */
    private init(canonicalName: String, aliases: [String]?)
    {
        // Init instance variables
        self.name = canonicalName
        self.aliases = (aliases ?? [])

        // Parent processing
        super.init()

        // Validate incoming params
        checkName(self.name)

        for alias in self.aliases {
            checkName(alias)
        }
    }

// MARK: - Properties

    /// The canonical name of this charset.
    public let name: String

    /// The charset's aliases.
    public let aliases: [String]

// MARK: - Functions

    /**
     * Tells whether the named charset is supported.
     *
     * @param  charsetName
     *         The name of the requested charset; may be either
     *         a canonical name or an alias
     *
     * @return  TRUE if, and only if, support for the named charset
     *          is available
     */
    public class func isSupported(charsetName: String) -> Bool {
        return (lookup(charsetName) != nil)
    }

    /**
     * Returns a charset object for the named charset.
     *
     * @param  charsetName
     *         The name of the requested charset; may be either
     *         a canonical name or an alias
     *
     * @return  A charset object for the named charset
     *
     * @throws  FatalError
     *          If no support for the named charset is available
     */
    public class func forName(charsetName: String) -> Charset
    {
        if let charset = lookup(charsetName) {
            return charset
        }

        // Terminate application with runtime exception
        mdc_fatalError("‘\(charsetName)’ charset is not supported.")
    }

// MARK: - Private Functions

    private class func lookup(charsetName: String) -> Charset? {
        return Inner.StandardProvider.charsetForName(charsetName.lowercaseString)
    }

    /**
     * Checks that the given string is a legal charset name.
     *
     * @param  name
     *         A purported charset name
     *
     * @throws  FatalError
     *          If the given name is not a legal charset name
     */
    private func checkName(name: String)
    {
        if name.isEmpty {
            mdc_fatalError("Illegal charset name.")
        }

        var idx = 0
        for ch in name.characters
        {
            let str =  String(ch).unicodeScalars
            let ucs =  str[str.startIndex].value

            if (ucs >= UnicodeScalar("A").value && ucs <= UnicodeScalar("Z").value) { idx += 1; continue; }
            if (ucs >= UnicodeScalar("a").value && ucs <= UnicodeScalar("z").value) { idx += 1; continue; }
            if (ucs >= UnicodeScalar("0").value && ucs <= UnicodeScalar("9").value) { idx += 1; continue; }

            if (ucs == UnicodeScalar("-").value && idx != 0) { idx += 1; continue; }
            if (ucs == UnicodeScalar(":").value && idx != 0) { idx += 1; continue; }
            if (ucs == UnicodeScalar("_").value && idx != 0) { idx += 1; continue; }
            if (ucs == UnicodeScalar(".").value && idx != 0) { idx += 1; continue; }

            mdc_fatalError("Illegal charset name.")
        }
    }

// MARK: - Constants

    private struct Inner {
        static let StandardProvider = StandardCharsets()
    }

}

// ----------------------------------------------------------------------------
// MARK: - @protocol Equatable, Printable, DebugPrintable
// ----------------------------------------------------------------------------

extension Charset // : CustomDebugStringConvertible
{
// MARK: - Properties

    public override var description: String {
        return self.name
    }

    public override var debugDescription: String {
        return self.name
    }

}

public func == (lhs: Charset, rhs: Charset) -> Bool {
    return (lhs.name.caseInsensitiveCompare(rhs.name) == .OrderedSame)
}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class US_ASCII: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "us-ascii"

            // Aliases
            static let Aliases = [
                "iso-ir-6",
                "ANSI_X3.4-1986",
                "ISO_646.irv:1991",
                "ASCII",
                "ISO646-US",
                "us",
                "IBM367",
                "cp367",
                "csASCII",
                "default",
                "646",
                "iso_646.irv:1983",
                "ANSI_X3.4-1968",
                "ascii7",
            ]
        }
    }
}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class ISO_8859_1: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "iso-8859-1"

            // Aliases
            static let Aliases = [
                "iso-ir-100",
                "ISO_8859-1",
                "latin1",
                "l1",
                "IBM819",
                "cp819",
                "csISOLatin1",
                "819",
                "IBM-819",
                "ISO8859_1",
                "ISO_8859-1:1987",
                "ISO_8859_1",
                "8859_1",
                "ISO8859-1",
            ]
        }
    }

    class ISO_8859_2: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "iso-8859-2"

            // Aliases
            static let Aliases = [
                "iso8859_2",
                "8859_2",
                "iso-ir-101",
                "ISO_8859-2",
                "ISO_8859-2:1987",
                "ISO8859-2",
                "latin2",
                "l2",
                "ibm912",
                "ibm-912",
                "cp912",
                "912",
                "csISOLatin2",
            ]
        }
    }
}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class UTF_8: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-8"

            // Aliases
            static let Aliases = [
                "UTF8",
                "unicode-1-1-utf-8",
            ]
        }
    }
}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class UTF_16: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-16"

            // Aliases
            static let Aliases = [
                "UTF_16",
                "utf16",
                "unicode",
                "UnicodeBig",
            ]
        }
    }

    class UTF_16BE: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-16be"

            // Aliases
            static let Aliases = [
                "UTF_16BE",
                "ISO-10646-UCS-2",
                "X-UTF-16BE",
                "UnicodeBigUnmarked",
            ]
        }
    }

    class UTF_16LE: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-16le"

            // Aliases
            static let Aliases = [
                "UTF_16LE",
                "X-UTF-16LE",
                "UnicodeLittleUnmarked",
            ]
        }
    }
}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class UTF_32: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-32"

            // Aliases
            static let Aliases = [
                "UTF_32",
                "UTF32",
            ]
        }
    }

    class UTF_32BE: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-32be"

            // Aliases
            static let Aliases = [
                "UTF_32BE",
                "X-UTF-32BE",
            ]
        }
    }

    class UTF_32LE: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "utf-32le"

            // Aliases
            static let Aliases = [
                "UTF_32LE",
                "X-UTF-32LE",
            ]
        }
    }

}

// ----------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------

extension Charset
{
    class WINDOWS_1250: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "windows-1250"

            // Aliases
            static let Aliases = [
                "cp1250",
                "cp5346",
            ]
        }
    }

    class WINDOWS_1251: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "windows-1251"

            // Aliases
            static let Aliases = [
                "cp1251",
                "cp5347",
                "ansi-1251",
            ]
        }
    }

    class WINDOWS_1252: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "windows-1252"

            // Aliases
            static let Aliases = [
                "cp1252",
                "cp5348",
            ]
        }
    }

    class WINDOWS_1253: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "windows-1253"

            // Aliases
            static let Aliases = [
                "cp1253",
                "cp5349",
            ]
        }
    }

    class WINDOWS_1254: Charset
    {
        init() {
            super.init(canonicalName: Const.Name, aliases: Const.Aliases)
        }

        struct Const
        {
            // Canonical name
            static let Name = "windows-1254"

            // Aliases
            static let Aliases = [
                "cp1254",
                "cp5350",
            ]
        }
    }
}

// ----------------------------------------------------------------------------
