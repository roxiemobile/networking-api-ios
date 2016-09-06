// ----------------------------------------------------------------------------
//
//  HttpStatus.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

import SwiftCommons

// ----------------------------------------------------------------------------

public struct HttpStatus
{
// MARK: - Construction

    private init(_ code: HttpStatusCode, _ reasonPhrase: String)
    {
        // Init instance variables
        self.code = code
        self.reasonPhrase = reasonPhrase
    }

// MARK: - Properties

    /// Integer value of this status code.
    public let code: HttpStatusCode

    /// Reason phrase of this status code.
    public let reasonPhrase: String

// MARK: - Functions

    /**
     * Whether this status code is in the HTTP series
     * {@link org.springframework.http.HttpStatus.Series#INFORMATIONAL}.
     * This is a shortcut for checking the value of {@link #series()}.
     */
    public func is1xxInformational() -> Bool {
        return (self.code.rawValue >= 100) && (self.code.rawValue < 200)
    }

    /**
     * Whether this status code is in the HTTP series
     * {@link org.springframework.http.HttpStatus.Series#SUCCESSFUL}.
     * This is a shortcut for checking the value of {@link #series()}.
     */
    public func is2xxSuccessful() -> Bool {
        return (self.code.rawValue >= 200) && (self.code.rawValue < 300)
    }

    /**
     * Whether this status code is in the HTTP series
     * {@link org.springframework.http.HttpStatus.Series#REDIRECTION}.
     * This is a shortcut for checking the value of {@link #series()}.
     */
    public func is3xxRedirection() -> Bool {
        return (self.code.rawValue >= 300) && (self.code.rawValue < 400)
    }

    /**
     * Whether this status code is in the HTTP series
     * {@link org.springframework.http.HttpStatus.Series#CLIENT_ERROR}.
     * This is a shortcut for checking the value of {@link #series()}.
     */
    public func is4xxClientError() -> Bool {
        return (self.code.rawValue >= 400) && (self.code.rawValue < 500)
    }

    /**
     * Whether this status code is in the HTTP series
     * {@link org.springframework.http.HttpStatus.Series#SERVER_ERROR}.
     * This is a shortcut for checking the value of {@link #series()}.
     */
    public func is5xxServerError() -> Bool {
        return (self.code.rawValue >= 500) && (self.code.rawValue < 600)
    }

    /**
     * Return the enum constant of this type with the specified numeric value.
     * @param statusCode the numeric value of the enum to be returned
     * @return the enum constant with the specified numeric value
     * @throws IllegalArgumentException if this enum has no constant for the specified numeric value
     */
    public static func valueOf(statusCode: Int) -> HttpStatus?
    {
        if let statusCode = HttpStatusCode(rawValue: statusCode)
        {
            switch statusCode
            {
                // 1xx Informational

                case .Continue:
                    return HttpStatus.Continue

                case .SwitchingProtocols:
                    return HttpStatus.SwitchingProtocols

                case .Processing:
                    return HttpStatus.Processing

                // 2xx Success

                case .Ok:
                    return HttpStatus.Ok

                case .Created:
                    return HttpStatus.Created

                case .Accepted:
                    return HttpStatus.Accepted

                case .NonAuthoritativeInformation:
                    return HttpStatus.NonAuthoritativeInformation

                case .NoContent:
                    return HttpStatus.NoContent

                case .ResetContent:
                    return HttpStatus.ResetContent

                case .PartialContent:
                    return HttpStatus.PartialContent

                case .MultiStatus:
                    return HttpStatus.MultiStatus

                case .AlreadyReported:
                    return HttpStatus.AlreadyReported

                case .ImUsed:
                    return HttpStatus.ImUsed

                // 3xx Redirection

                case .MultipleChoices:
                    return HttpStatus.MultipleChoices

                case .MovedPermanently:
                    return HttpStatus.MovedPermanently

                case .Found:
                    return HttpStatus.Found

                case .SeeOther:
                    return HttpStatus.SeeOther

                case .NotModified:
                    return HttpStatus.NotModified

                case .UseProxy:
                    return HttpStatus.UseProxy

                case .TemporaryRedirect:
                    return HttpStatus.TemporaryRedirect

                // 4xx Client Error

                case .BadRequest:
                    return HttpStatus.BadRequest

                case .Unauthorized:
                    return HttpStatus.Unauthorized

                case .PaymentRequired:
                    return HttpStatus.PaymentRequired

                case .Forbidden:
                    return HttpStatus.Forbidden

                case .NotFound:
                    return HttpStatus.NotFound

                case .MethodNotAllowed:
                    return HttpStatus.MethodNotAllowed

                case .NotAcceptable:
                    return HttpStatus.NotAcceptable

                case .ProxyAuthenticationRequired:
                    return HttpStatus.ProxyAuthenticationRequired

                case .RequestTimeout:
                    return HttpStatus.RequestTimeout

                case .Conflict:
                    return HttpStatus.Conflict

                case .Gone:
                    return HttpStatus.Gone

                case .LengthRequired:
                    return HttpStatus.LengthRequired

                case .PreconditionFailed:
                    return HttpStatus.PreconditionFailed

                case .RequestEntityTooLarge:
                    return HttpStatus.RequestEntityTooLarge

                case .RequestUriTooLong:
                    return HttpStatus.RequestUriTooLong

                case .UnsupportedMediaType:
                    return HttpStatus.UnsupportedMediaType

                case .RequestedRangeNotSatisfiable:
                    return HttpStatus.RequestedRangeNotSatisfiable

                case .ExpectationFailed:
                    return HttpStatus.ExpectationFailed

                case .InsufficientSpaceOnResource:
                    return HttpStatus.InsufficientSpaceOnResource

                case .MethodFailure:
                    return HttpStatus.MethodFailure

                case .DestinationLocked:
                    return HttpStatus.DestinationLocked

                case .UnprocessableEntity:
                    return HttpStatus.UnprocessableEntity

                case .Locked:
                    return HttpStatus.Locked

                case .FailedDependency:
                    return HttpStatus.FailedDependency

                case .UpgradeRequired:
                    return HttpStatus.UpgradeRequired

                // 5xx Server Error

                case .InternalServerError:
                    return HttpStatus.InternalServerError

                case .NotImplemented:
                    return HttpStatus.NotImplemented

                case .BadGateway:
                    return HttpStatus.BadGateway

                case .ServiceUnavailable:
                    return HttpStatus.ServiceUnavailable

                case .GatewayTimeout:
                    return HttpStatus.GatewayTimeout

                case .HttpVersionNotSupported:
                    return HttpStatus.HttpVersionNotSupported

                case .VariantAlsoNegotiates:
                    return HttpStatus.VariantAlsoNegotiates

                case .InsufficientStorage:
                    return HttpStatus.InsufficientStorage

                case .LoopDetected:
                    return HttpStatus.LoopDetected

                case .NotExtended:
                    return HttpStatus.NotExtended
            }
        }

        // Terminate application with runtime exception
        mdc_fatalError("No matching constant for [\(statusCode)].")
    }

    /// Return a string representation of this status code.
    public func toString() -> String {
        return "\(self.code.rawValue) \(self.reasonPhrase)"
    }

// MARK: - Constants

    // 1xx Informational

    /**
     * {@code 100 Continue}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.1.1">HTTP/1.1</a>
     */
    public static let Continue = HttpStatus(HttpStatusCode.Continue, "Continue")

    /**
     * {@code 101 Switching Protocols}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.1.2">HTTP/1.1</a>
     */
    public static let SwitchingProtocols = HttpStatus(HttpStatusCode.SwitchingProtocols, "Switching Protocols")

    /**
     * {@code 102 Processing}.
     * @see <a href="http://tools.ietf.org/html/rfc2518#section-10.1">WebDAV</a>
     */
    public static let Processing = HttpStatus(HttpStatusCode.Processing, "Processing")

    // 2xx Success

    /**
     * {@code 200 OK}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.1">HTTP/1.1</a>
     */
    public static let Ok = HttpStatus(HttpStatusCode.Ok, "OK")

    /**
     * {@code 201 Created}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.2">HTTP/1.1</a>
     */
    public static let Created = HttpStatus(HttpStatusCode.Created, "Created")

    /**
     * {@code 202 Accepted}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.3">HTTP/1.1</a>
     */
    public static let Accepted = HttpStatus(HttpStatusCode.Accepted, "Accepted")

    /**
     * {@code 203 Non-Authoritative Information}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.4">HTTP/1.1</a>
     */
    public static let NonAuthoritativeInformation = HttpStatus(HttpStatusCode.NonAuthoritativeInformation, "Non-Authoritative Information")

    /**
     * {@code 204 No Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.5">HTTP/1.1</a>
     */
    public static let NoContent = HttpStatus(HttpStatusCode.NoContent, "No Content")

    /**
     * {@code 205 Reset Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.6">HTTP/1.1</a>
     */
    public static let ResetContent = HttpStatus(HttpStatusCode.ResetContent, "Reset Content")

    /**
     * {@code 206 Partial Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.7">HTTP/1.1</a>
     */
    public static let PartialContent = HttpStatus(HttpStatusCode.PartialContent, "Partial Content")

    /**
     * {@code 207 Multi-Status}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-13">WebDAV</a>
     */
    public static let MultiStatus = HttpStatus(HttpStatusCode.MultiStatus, "Multi-Status")

    /**
     * {@code 208 Already Reported}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-bind-27#section-7.1">WebDAV Binding Extensions</a>
     */
    public static let AlreadyReported = HttpStatus(HttpStatusCode.AlreadyReported, "Already Reported")

    /**
     * {@code 226 IM Used}.
     * @see <a href="http://tools.ietf.org/html/rfc3229#section-10.4.1">Delta encoding in HTTP</a>
     */
    public static let ImUsed = HttpStatus(HttpStatusCode.ImUsed, "IM Used")

    // 3xx Redirection

    /**
     * {@code 300 Multiple Choices}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.1">HTTP/1.1</a>
     */
    public static let MultipleChoices = HttpStatus(HttpStatusCode.MultipleChoices, "Multiple Choices")

    /**
     * {@code 301 Moved Permanently}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.2">HTTP/1.1</a>
     */
    public static let MovedPermanently = HttpStatus(HttpStatusCode.MovedPermanently, "Moved Permanently")

    /**
     * {@code 302 Found}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.3">HTTP/1.1</a>
     */
    public static let Found = HttpStatus(HttpStatusCode.Found, "Found")

//    /**
//     * {@code 302 Moved Temporarily}.
//     * @see <a href="http://tools.ietf.org/html/rfc1945#section-9.3">HTTP/1.0</a>
//     */
//    public static let MovedTemporarily = HttpStatus(HttpStatusCode.MovedTemporarily, "Moved Temporarily")

    /**
     * {@code 303 See Other}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.4">HTTP/1.1</a>
     */
    public static let SeeOther = HttpStatus(HttpStatusCode.SeeOther, "See Other")

    /**
     * {@code 304 Not Modified}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.5">HTTP/1.1</a>
     */
    public static let NotModified = HttpStatus(HttpStatusCode.NotModified, "Not Modified")

    /**
     * {@code 305 Use Proxy}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.6">HTTP/1.1</a>
     */
    public static let UseProxy = HttpStatus(HttpStatusCode.UseProxy, "Use Proxy")

    /**
     * {@code 307 Temporary Redirect}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.8">HTTP/1.1</a>
     */
    public static let TemporaryRedirect = HttpStatus(HttpStatusCode.TemporaryRedirect, "Temporary Redirect")

    // 4xx Client Error

    /**
     * {@code 400 Bad Request}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.1">HTTP/1.1</a>
     */
    public static let BadRequest = HttpStatus(HttpStatusCode.BadRequest, "Bad Request")

    /**
     * {@code 401 Unauthorized}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.2">HTTP/1.1</a>
     */
    public static let Unauthorized = HttpStatus(HttpStatusCode.Unauthorized, "Unauthorized")

    /**
     * {@code 402 Payment Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.3">HTTP/1.1</a>
     */
    public static let PaymentRequired = HttpStatus(HttpStatusCode.PaymentRequired, "Payment Required")

    /**
     * {@code 403 Forbidden}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.4">HTTP/1.1</a>
     */
    public static let Forbidden = HttpStatus(HttpStatusCode.Forbidden, "Forbidden")

    /**
     * {@code 404 Not Found}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.5">HTTP/1.1</a>
     */
    public static let NotFound = HttpStatus(HttpStatusCode.NotFound, "Not Found")

    /**
     * {@code 405 Method Not Allowed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.6">HTTP/1.1</a>
     */
    public static let MethodNotAllowed = HttpStatus(HttpStatusCode.MethodNotAllowed, "Method Not Allowed")

    /**
     * {@code 406 Not Acceptable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.7">HTTP/1.1</a>
     */
    public static let NotAcceptable = HttpStatus(HttpStatusCode.NotAcceptable, "Not Acceptable")

    /**
     * {@code 407 Proxy Authentication Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.8">HTTP/1.1</a>
     */
    public static let ProxyAuthenticationRequired = HttpStatus(HttpStatusCode.ProxyAuthenticationRequired, "Proxy Authentication Required")

    /**
     * {@code 408 Request Timeout}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.9">HTTP/1.1</a>
     */
    public static let RequestTimeout = HttpStatus(HttpStatusCode.RequestTimeout, "Request Time-out")

    /**
     * {@code 409 Conflict}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.10">HTTP/1.1</a>
     */
    public static let Conflict = HttpStatus(HttpStatusCode.Conflict, "Conflict")

    /**
     * {@code 410 Gone}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.11">HTTP/1.1</a>
     */
    public static let Gone = HttpStatus(HttpStatusCode.Gone, "Gone")

    /**
     * {@code 411 Length Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.12">HTTP/1.1</a>
     */
    public static let LengthRequired = HttpStatus(HttpStatusCode.LengthRequired, "Length Required")

    /**
     * {@code 412 Precondition failed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.13">HTTP/1.1</a>
     */
    public static let PreconditionFailed = HttpStatus(HttpStatusCode.PreconditionFailed, "Precondition Failed")

    /**
     * {@code 413 Request Entity Too Large}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.14">HTTP/1.1</a>
     */
    public static let RequestEntityTooLarge = HttpStatus(HttpStatusCode.RequestEntityTooLarge, "Request Entity Too Large")

    /**
     * {@code 414 Request-URI Too Long}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.15">HTTP/1.1</a>
     */
    public static let RequestUriTooLong = HttpStatus(HttpStatusCode.RequestUriTooLong, "Request-URI Too Large")

    /**
     * {@code 415 Unsupported Media Type}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.16">HTTP/1.1</a>
     */
    public static let UnsupportedMediaType = HttpStatus(HttpStatusCode.UnsupportedMediaType, "Unsupported Media Type")

    /**
     * {@code 416 Requested Range Not Satisfiable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.17">HTTP/1.1</a>
     */
    public static let RequestedRangeNotSatisfiable = HttpStatus(HttpStatusCode.RequestedRangeNotSatisfiable, "Requested range not satisfiable")

    /**
     * {@code 417 Expectation Failed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.18">HTTP/1.1</a>
     */
    public static let ExpectationFailed = HttpStatus(HttpStatusCode.ExpectationFailed, "Expectation Failed")

    /**
     * {@code 419 Insufficient Space on Resource}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.4">WebDAV Draft</a>
     */
    public static let InsufficientSpaceOnResource = HttpStatus(HttpStatusCode.InsufficientSpaceOnResource, "Insufficient Space On Resource")

    /**
     * {@code 420 Method Failure}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.5">WebDAV Draft</a>
     */
    public static let MethodFailure = HttpStatus(HttpStatusCode.MethodFailure, "Method Failure")

    /**
     * {@code 421 Destination Locked}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.6">WebDAV Draft</a>
     */
    public static let DestinationLocked = HttpStatus(HttpStatusCode.DestinationLocked, "Destination Locked")

    /**
     * {@code 422 Unprocessable Entity}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.2">WebDAV</a>
     */
    public static let UnprocessableEntity = HttpStatus(HttpStatusCode.UnprocessableEntity, "Unprocessable Entity")

    /**
     * {@code 423 Locked}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.3">WebDAV</a>
     */
    public static let Locked = HttpStatus(HttpStatusCode.Locked, "Locked")

    /**
     * {@code 424 Failed Dependency}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.4">WebDAV</a>
     */
    public static let FailedDependency = HttpStatus(HttpStatusCode.FailedDependency, "Failed Dependency")

    /**
     * {@code 426 Upgrade Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2817#section-6">Upgrading to TLS Within HTTP/1.1</a>
     */
    public static let UpgradeRequired = HttpStatus(HttpStatusCode.UpgradeRequired, "Upgrade Required")

    // 5xx Server Error

    /**
     * {@code 500 Internal Server Error}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.1">HTTP/1.1</a>
     */
    public static let InternalServerError = HttpStatus(HttpStatusCode.InternalServerError, "Internal Server Error")

    /**
     * {@code 501 Not Implemented}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.2">HTTP/1.1</a>
     */
    public static let NotImplemented = HttpStatus(HttpStatusCode.NotImplemented, "Not Implemented")

    /**
     * {@code 502 Bad Gateway}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.3">HTTP/1.1</a>
     */
    public static let BadGateway = HttpStatus(HttpStatusCode.BadGateway, "Bad Gateway")

    /**
     * {@code 503 Service Unavailable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.4">HTTP/1.1</a>
     */
    public static let ServiceUnavailable = HttpStatus(HttpStatusCode.ServiceUnavailable, "Service Unavailable")

    /**
     * {@code 504 Gateway Timeout}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.5">HTTP/1.1</a>
     */
    public static let GatewayTimeout = HttpStatus(HttpStatusCode.GatewayTimeout, "Gateway Time-out")

    /**
     * {@code 505 HTTP Version Not Supported}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.6">HTTP/1.1</a>
     */
    public static let HttpVersionNotSupported = HttpStatus(HttpStatusCode.HttpVersionNotSupported, "HTTP Version not supported")

    /**
     * {@code 506 Variant Also Negotiates}
     * @see <a href="http://tools.ietf.org/html/rfc2295#section-8.1">Transparent Content Negotiation</a>
     */
    public static let VariantAlsoNegotiates = HttpStatus(HttpStatusCode.VariantAlsoNegotiates, "Variant Also Negotiates")

    /**
     * {@code 507 Insufficient Storage}
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.5">WebDAV</a>
     */
    public static let InsufficientStorage = HttpStatus(HttpStatusCode.InsufficientStorage, "Insufficient Storage")

    /**
     * {@code 508 Loop Detected}
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-bind-27#section-7.2">WebDAV Binding Extensions</a>
      */
    public static let LoopDetected = HttpStatus(HttpStatusCode.LoopDetected, "Loop Detected")

    /**
     * {@code 510 Not Extended}
     * @see <a href="http://tools.ietf.org/html/rfc2774#section-7">HTTP Extension Framework</a>
     */
    public static let NotExtended = HttpStatus(HttpStatusCode.NotExtended, "Not Extended")

}

// ----------------------------------------------------------------------------
