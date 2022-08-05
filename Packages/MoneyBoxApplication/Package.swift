// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneyBoxApplication",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MoneyBoxApplication", targets: ["MoneyBoxApplication"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "MoneyBoxApplication", dependencies: []),
        .testTarget(name: "MoneyBoxApplicationTests", dependencies: ["MoneyBoxApplication"])
    ]
)
