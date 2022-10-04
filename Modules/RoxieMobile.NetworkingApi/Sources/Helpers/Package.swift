// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Helpers",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "NetworkingApiHelpers",
            type: .static,
            targets: [
                "NetworkingApiHelpers",
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "NetworkingApi.Http",
            path: "../Http"
        ),
        .package(
            name: "NetworkingApi.ObjC",
            path: "../ObjC"
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiHelpers",
            dependencies: [
                .product(name: "NetworkingApiHttp", package: "NetworkingApi.Http"),
                .product(name: "NetworkingApiObjC", package: "NetworkingApi.ObjC"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
