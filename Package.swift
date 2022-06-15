// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PagoUISDK",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PagoUISDK",
            targets: ["PagoUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/alexruperez/lottie-ios.git", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "PagoUISDK",
            url: "https://github.com/PagoApp/ios-ui-spm/releases/download/0.0.3/PagoUISDK.xcframework.zip",
            checksum: "1e9afad586300bc8de6d1f682624a41fe56b1a3247c70fa84c45f1b06c85f935"),
        .target(
            name: "PagoUI",
            dependencies: [
                .target(name: "PagoUISDK"),
                .product(name: "Lottie", package: "lottie-ios")
            ]),
        .testTarget(
            name: "PagoUITests",
            dependencies: ["PagoUISDK"]),
    ]
)
