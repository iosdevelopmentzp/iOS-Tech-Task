// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneyBoxApplication",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MoneyBoxApplication", targets: ["Core"]),
        .library(name: "Core", targets: ["Core"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "MoneyBoxApplication", dependencies: ["Core"]),
        
        .target(name: "Core", dependencies: [])
    ]
)
