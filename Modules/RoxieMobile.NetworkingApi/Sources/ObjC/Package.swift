// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.ObjC",
    platforms: [
        .iOS(.v13),
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
            exact: "5.5.0"
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiObjC",
            dependencies: [
                "Alamofire",
            ],
            path: "Sources",
            exclude: [
                "NetworkingApiObjC.swift",
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
