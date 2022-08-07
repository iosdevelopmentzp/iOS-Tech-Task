// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneyBoxApplication",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MoneyBoxApplication", targets: ["UseCases"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "UseCases", targets: ["UseCases"]),
        .library(name: "SettingsStorage", targets: ["SettingsStorage"]),
        .library(name: "AppNotifier", targets: ["AppNotifier"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.1"),
        .package(url: "https://github.com/konkab/AlamofireNetworkActivityLogger.git", .upToNextMajor(from: "3.4.0"))
    ],
    targets: [
        .target(name: "MoneyBoxApplication", dependencies: [
            "UseCases"
        ]),
        
        .target(name: "Core"),
        
        .target(name: "Networking", dependencies: [
            "Core",
            "Alamofire",
            "AlamofireNetworkActivityLogger"
        ]),
        
        .target(name: "UseCases", dependencies: [
            "Core",
            "Networking",
            "SettingsStorage",
            "AppNotifier"
        ]),
        
        .target(name: "SettingsStorage", dependencies: []),
        
        .target(name: "AppNotifier", dependencies: [])
    ]
)
