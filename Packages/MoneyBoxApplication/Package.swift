// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneyBoxApplication",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MoneyBoxApplication", targets: ["Networking"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Networking", targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.1")
    ],
    targets: [
        .target(name: "MoneyBoxApplication", dependencies: [
            "Networking"
        ]),
        
        .target(name: "Core"),
        
        .target(name: "Networking", dependencies: [
            "Core",
            "Alamofire"
        ]),
    ]
)
