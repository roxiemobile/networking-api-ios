// swift-tools-version:5.3

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.ObjC",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetworkingApiObjC",
            type: .static,
            targets: [
                "NetworkingApiObjC",
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMinor(from: "4.9.1")
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiObjC",
            dependencies: [
                .byName(name: "Alamofire"),
            ],
            path: "Sources",
            exclude: [
                "NetworkingApiObjC.swift",
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
