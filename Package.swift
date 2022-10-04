// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi",
    platforms: [
        .iOS(.v13),
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
            exact: "5.6.2"
        ),
        .package(
            url: "https://github.com/roxiemobile/swift-commons-ios",
            exact: "1.7.0"
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON",
            exact: "5.0.1"
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
                .product(name: "SwiftCommonsDiagnostics", package: "swift-commons-ios"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Http/Sources"
        ),
        .target(
            name: "NetworkingApiObjC",
            dependencies: [
                "Alamofire",
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/ObjC/Sources",
            exclude: [
                "NetworkingApiObjC.swift",
            ]
        ),
        .target(
            name: "NetworkingApiRest",
            dependencies: [
                "SwiftyJSON",
                .product(name: "SwiftCommonsData", package: "swift-commons-ios"),
                .target(name: "NetworkingApiHelpers"),
            ],
            path: "Modules/RoxieMobile.NetworkingApi/Sources/Rest/Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
