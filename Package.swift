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
            name: "NetworkingApiHttp",
            type: .static,
            targets: ["NetworkingApiHttp"]
        ),
        .library(
            name: "NetworkingApiObjC",
            type: .static,
            targets: ["NetworkingApiObjC"]
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
    ],
    targets: [
        .target(
            name: "NetworkingApi",
            dependencies: [
                .target(name: "NetworkingApiHttp"),
                .target(name: "NetworkingApiObjC"),
            ]
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
    ],
    swiftLanguageVersions: [.v5]
)
