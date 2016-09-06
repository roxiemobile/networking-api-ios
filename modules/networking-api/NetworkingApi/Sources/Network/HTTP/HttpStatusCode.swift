// ----------------------------------------------------------------------------
//
//  HttpStatusCode.swift
//
//  @author     Alexander Bragin <alexander.bragin@gmail.com>
//  @copyright  Copyright (c) 2015, MediariuM Ltd. All rights reserved.
//  @link       http://www.mediarium.com/
//
// ----------------------------------------------------------------------------

public enum HttpStatusCode: Int
{
// MARK: - 1xx Informational

    /**
     * {@code 100 Continue}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.1.1">HTTP/1.1</a>
     */
    case Continue = 100

    /**
     * {@code 101 Switching Protocols}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.1.2">HTTP/1.1</a>
     */
    case SwitchingProtocols = 101

    /**
     * {@code 102 Processing}.
     * @see <a href="http://tools.ietf.org/html/rfc2518#section-10.1">WebDAV</a>
     */
    case Processing = 102

// MARK: - 2xx Success

    /**
     * {@code 200 OK}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.1">HTTP/1.1</a>
     */
    case Ok = 200

    /**
     * {@code 201 Created}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.2">HTTP/1.1</a>
     */
    case Created = 201

    /**
     * {@code 202 Accepted}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.3">HTTP/1.1</a>
     */
    case Accepted = 202

    /**
     * {@code 203 Non-Authoritative Information}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.4">HTTP/1.1</a>
     */
    case NonAuthoritativeInformation = 203

    /**
     * {@code 204 No Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.5">HTTP/1.1</a>
     */
    case NoContent = 204

    /**
     * {@code 205 Reset Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.6">HTTP/1.1</a>
     */
    case ResetContent = 205

    /**
     * {@code 206 Partial Content}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.2.7">HTTP/1.1</a>
     */
    case PartialContent = 206

    /**
     * {@code 207 Multi-Status}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-13">WebDAV</a>
     */
    case MultiStatus = 207

    /**
     * {@code 208 Already Reported}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-bind-27#section-7.1">WebDAV Binding Extensions</a>
     */
    case AlreadyReported = 208

    /**
     * {@code 226 IM Used}.
     * @see <a href="http://tools.ietf.org/html/rfc3229#section-10.4.1">Delta encoding in HTTP</a>
     */
    case ImUsed = 226

// MARK: - 3xx Redirection

    /**
     * {@code 300 Multiple Choices}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.1">HTTP/1.1</a>
     */
    case MultipleChoices = 300

    /**
     * {@code 301 Moved Permanently}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.2">HTTP/1.1</a>
     */
    case MovedPermanently = 301

    /**
     * {@code 302 Found}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.3">HTTP/1.1</a>
     */
    case Found = 302

//    /**
//     * {@code 302 Moved Temporarily}.
//     * @see <a href="http://tools.ietf.org/html/rfc1945#section-9.3">HTTP/1.0</a>
//     */
//    case MovedTemporarily = 302

    /**
     * {@code 303 See Other}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.4">HTTP/1.1</a>
     */
    case SeeOther = 303

    /**
     * {@code 304 Not Modified}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.5">HTTP/1.1</a>
     */
    case NotModified = 304

    /**
     * {@code 305 Use Proxy}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.6">HTTP/1.1</a>
     */
    case UseProxy = 305

    /**
     * {@code 307 Temporary Redirect}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.3.8">HTTP/1.1</a>
     */
    case TemporaryRedirect = 307

// MARK: - 4xx Client Error

    /**
     * {@code 400 Bad Request}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.1">HTTP/1.1</a>
     */
    case BadRequest = 400

    /**
     * {@code 401 Unauthorized}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.2">HTTP/1.1</a>
     */
    case Unauthorized = 401

    /**
     * {@code 402 Payment Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.3">HTTP/1.1</a>
     */
    case PaymentRequired = 402

    /**
     * {@code 403 Forbidden}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.4">HTTP/1.1</a>
     */
    case Forbidden = 403

    /**
     * {@code 404 Not Found}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.5">HTTP/1.1</a>
     */
    case NotFound = 404

    /**
     * {@code 405 Method Not Allowed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.6">HTTP/1.1</a>
     */
    case MethodNotAllowed = 405

    /**
     * {@code 406 Not Acceptable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.7">HTTP/1.1</a>
     */
    case NotAcceptable = 406

    /**
     * {@code 407 Proxy Authentication Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.8">HTTP/1.1</a>
     */
    case ProxyAuthenticationRequired = 407

    /**
     * {@code 408 Request Timeout}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.9">HTTP/1.1</a>
     */
    case RequestTimeout = 408

    /**
     * {@code 409 Conflict}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.10">HTTP/1.1</a>
     */
    case Conflict = 409

    /**
     * {@code 410 Gone}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.11">HTTP/1.1</a>
     */
    case Gone = 410

    /**
     * {@code 411 Length Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.12">HTTP/1.1</a>
     */
    case LengthRequired = 411

    /**
     * {@code 412 Precondition failed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.13">HTTP/1.1</a>
     */
    case PreconditionFailed = 412

    /**
     * {@code 413 Request Entity Too Large}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.14">HTTP/1.1</a>
     */
    case RequestEntityTooLarge = 413

    /**
     * {@code 414 Request-URI Too Long}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.15">HTTP/1.1</a>
     */
    case RequestUriTooLong = 414

    /**
     * {@code 415 Unsupported Media Type}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.16">HTTP/1.1</a>
     */
    case UnsupportedMediaType = 415

    /**
     * {@code 416 Requested Range Not Satisfiable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.17">HTTP/1.1</a>
     */
    case RequestedRangeNotSatisfiable = 416

    /**
     * {@code 417 Expectation Failed}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.4.18">HTTP/1.1</a>
     */
    case ExpectationFailed = 417

    /**
     * {@code 419 Insufficient Space on Resource}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.4">WebDAV Draft</a>
     */
    case InsufficientSpaceOnResource = 419

    /**
     * {@code 420 Method Failure}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.5">WebDAV Draft</a>
     */
    case MethodFailure = 420

    /**
     * {@code 421 Destination Locked}.
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-protocol-05#section-10.6">WebDAV Draft</a>
     */
    case DestinationLocked = 421

    /**
     * {@code 422 Unprocessable Entity}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.2">WebDAV</a>
     */
    case UnprocessableEntity = 422

    /**
     * {@code 423 Locked}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.3">WebDAV</a>
     */
    case Locked = 423

    /**
     * {@code 424 Failed Dependency}.
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.4">WebDAV</a>
     */
    case FailedDependency = 424

    /**
     * {@code 426 Upgrade Required}.
     * @see <a href="http://tools.ietf.org/html/rfc2817#section-6">Upgrading to TLS Within HTTP/1.1</a>
     */
    case UpgradeRequired = 426

// MARK: - 5xx Server Error

    /**
     * {@code 500 Internal Server Error}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.1">HTTP/1.1</a>
     */
    case InternalServerError = 500

    /**
     * {@code 501 Not Implemented}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.2">HTTP/1.1</a>
     */
    case NotImplemented = 501

    /**
     * {@code 502 Bad Gateway}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.3">HTTP/1.1</a>
     */
    case BadGateway = 502

    /**
     * {@code 503 Service Unavailable}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.4">HTTP/1.1</a>
     */
    case ServiceUnavailable = 503

    /**
     * {@code 504 Gateway Timeout}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.5">HTTP/1.1</a>
     */
    case GatewayTimeout = 504

    /**
     * {@code 505 HTTP Version Not Supported}.
     * @see <a href="http://tools.ietf.org/html/rfc2616#section-10.5.6">HTTP/1.1</a>
     */
    case HttpVersionNotSupported = 505

    /**
     * {@code 506 Variant Also Negotiates}
     * @see <a href="http://tools.ietf.org/html/rfc2295#section-8.1">Transparent Content Negotiation</a>
     */
    case VariantAlsoNegotiates = 506

    /**
     * {@code 507 Insufficient Storage}
     * @see <a href="http://tools.ietf.org/html/rfc4918#section-11.5">WebDAV</a>
     */
    case InsufficientStorage = 507

    /**
     * {@code 508 Loop Detected}
     * @see <a href="http://tools.ietf.org/html/draft-ietf-webdav-bind-27#section-7.2">WebDAV Binding Extensions</a>
      */
    case LoopDetected = 508

    /**
     * {@code 510 Not Extended}
     * @see <a href="http://tools.ietf.org/html/rfc2774#section-7">HTTP Extension Framework</a>
     */
    case NotExtended = 510

}

// ----------------------------------------------------------------------------
