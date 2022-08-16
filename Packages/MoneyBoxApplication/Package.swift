// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneyBoxApplication",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MoneyBoxApplication", targets: ["Coordinator", "DependencyResolver"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "AppViews", targets: ["AppViews"]),
        .library(name: "AppResources", targets: ["AppResources"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "UseCases", targets: ["UseCases"]),
        .library(name: "SettingsStorage", targets: ["SettingsStorage"]),
        .library(name: "AppNotifier", targets: ["AppNotifier"]),
        .library(name: "Coordinator", targets: ["Coordinator"]),
        .library(name: "Assemblies", targets: ["Assemblies"]),
        .library(name: "DependencyResolver", targets: ["DependencyResolver"]),
        .library(name: "MVVM", targets: ["MVVM"]),
        // Scenes
        .library(name: "SceneLogin", targets: ["SceneLogin"]),
        .library(name: "SceneAccount", targets: ["SceneAccount"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.1"),
        .package(url: "https://github.com/konkab/AlamofireNetworkActivityLogger.git", .upToNextMajor(from: "3.4.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.8.0")
    ],
    targets: [
        .target(name: "MoneyBoxApplication", dependencies: [
            "Coordinator",
            "DependencyResolver"
        ]),
        
        .target(name: "Core"),
        
        .target(name: "Extensions"),
        
        .target(name: "AppViews"),
        
        .target(name: "AppResources", resources: [.process("Resources/Fonts/")]),
        
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
        
        .target(name: "AppNotifier", dependencies: []),
        
        .target(name: "Coordinator", dependencies: [
            "DependencyResolver",
            "SceneLogin",
            "SceneAccount"
        ]),
        
        .target(name: "Assemblies", dependencies: [
            "Swinject",
            "Networking",
            "UseCases",
            "SettingsStorage",
            "AppNotifier"
        ]),
        
        .target(name: "DependencyResolver", dependencies: [
            "Swinject",
            "Assemblies"
        ]),
        
        .target(name: "MVVM"),
        
        // Scenes
        
        .target(name: "SceneLogin", dependencies: [
            "SnapKit",
            "MVVM",
            "UseCases",
            "Core",
            "AppResources",
            "Extensions",
            "AppViews"
        ]),
        
        .target(name: "SceneAccount", dependencies: [
            "SnapKit",
            "MVVM",
            "UseCases",
            "Core",
            "AppResources",
            "Extensions"
        ])
    ]
)
