// swift-tools-version:5.3

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetworkingApi",
            type: .static,
            targets: ["NetworkingApi"]
        ),

        .library(
            name: "NetworkingApiConverters",
            type: .static,
            targets: ["NetworkingApiConverters"]
        ),
        .library(
            name: "NetworkingApiHelpers",
            type: .static,
            targets: ["NetworkingApiHelpers"]
        ),
        .library(
            name: "NetworkingApiHttp",
            type: .static,
            targets: ["NetworkingApiHttp"]
        ),
        .library(
            name: "NetworkingApiObjC",
            type: .static,
            targets: ["NetworkingApiObjC"]
        ),
        .library(
            name: "NetworkingApiRest",
            type: .static,
            targets: ["NetworkingApiRest"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMinor(from: "4.9.1")
        ),
        .package(
            name: "SwiftCommons",
            url: "https://github.com/roxiemobile/swift-commons.ios",
            .upToNextMinor(from: "1.6.0")
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON",
            .upToNextMinor(from: "5.0.1")
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApi",
            dependencies: [
                .target(name: "NetworkingApiConverters"),
                .target(name: "NetworkingApiHelpers"),
                .target(name: "NetworkingApiHttp"),
                .target(name: "NetworkingApiObjC"),
                .target(name: "NetworkingApiRest"),
            ]
        ),

        .target(
            name: "NetworkingApiConverters",
            dependencies: [
                .target(name: "NetworkingApiRest"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Converters/Sources"
        ),
        .target(
            name: "NetworkingApiHelpers",
            dependencies: [
                .target(name: "NetworkingApiHttp"),
                .target(name: "NetworkingApiObjC"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Helpers/Sources"
        ),
        .target(
            name: "NetworkingApiHttp",
            dependencies: [
                .product(name: "SwiftCommonsDiagnostics", package: "SwiftCommons"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Http/Sources"
        ),
        .target(
            name: "NetworkingApiObjC",
            dependencies: [
                .byName(name: "Alamofire"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/ObjC/Sources",
            exclude: [
                "NetworkingApiObjC.swift",
            ]
        ),
        .target(
            name: "NetworkingApiRest",
            dependencies: [
                .byName(name: "SwiftyJSON"),
                .product(name: "SwiftCommonsData", package: "SwiftCommons"),
                .target(name: "NetworkingApiHelpers"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Rest/Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
