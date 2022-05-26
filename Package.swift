// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PagoUI",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PagoUI",
            targets: ["PagoUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/alexruperez/lottie-ios.git", exact: "3.1.6"),
        .package(url: "https://github.com/Giphy/giphy-ios-sdk", exact: "2.1.20")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PagoUI",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "GiphyUISDK", package: "giphy-ios-sdk")
            ],
            resources: [
                .process("Resources/loading.json")]),
        .testTarget(
            name: "PagoUITests",
            dependencies: ["PagoUI"]),
    ]
)
