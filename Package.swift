// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBM Security Verify",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FIDO2",
            targets: ["FIDO2"]),
        .library(
            name: "Adaptive",
            targets: ["Adaptive"]),
        .library(
            name: "Core",
            targets: ["Core"]),
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FIDO2",
            path: "Sources/fido2"),
        .testTarget(
            name: "FIDO2 Tests",
            dependencies: ["FIDO2"],
            path: "Tests/FIDO2Tests",
            resources: [
                .copy("JSONFiles")
            ],
            linkerSettings: [
              .linkedFramework(
                "XCTest",
                .when(platforms: [.iOS])),
            ]),
        .target(
            name: "Adaptive",
            path: "Sources/adaptive"),
        .testTarget(
            name: "Adaptive Tests",
            dependencies: ["Adaptive"],
            path: "Tests/AdaptiveTests",
            exclude: ["tas/"],
            linkerSettings: [
              .linkedFramework(
                "XCTest",
                .when(platforms: [.iOS])),
            ]),
        .target(
            name: "Core",
            path: "Sources/core"),
        .testTarget(
            name: "Core Tests",
            dependencies: ["Core"],
            path: "Tests/CoreTests",
            linkerSettings: [
              .linkedFramework(
                "XCTest",
                .when(platforms: [.iOS])),
            ]),
        .target(
            name: "Authentication",
            dependencies: ["Core"],
            path: "Sources/authentication"),
        .testTarget(
            name: "Authentication Tests",
            dependencies: ["Authentication", "Core"],
            path: "Tests/AuthenticationTests",
            linkerSettings: [
              .linkedFramework(
                "XCTest",
                .when(platforms: [.iOS])),
            ]),
    ]
)
