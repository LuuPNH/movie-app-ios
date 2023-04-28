// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "package-movie-ios",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "package-movie-ios",
            targets: ["package-movie-ios", "Domain", "Data", "DependencyKit", "UI", "Common", "Resources"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Moya/Moya", from: "15.0.3"),
        .package(url: "https://github.com/kean/NukeUI.git", from: "0.8.3"),
        .package(url: "https://github.com/exyte/PopupView.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "package-movie-ios",
            dependencies: []),
        .target(name: "Domain",
                dependencies: ["DependencyKit"]),
        .target(name: "Data",
                dependencies: [
                    "DependencyKit",
                    "Domain",
                    "Common",
                    .product(name: "CombineMoya", package: "Moya")
                ],
                resources: [
                    .process("Impl/Configuration/ConfigurationEnvironment.plist")
                ]
               ),
        .target(name: "DependencyKit",
                dependencies: []),
        .target(name: "Resources",
                dependencies: []),
        .target(name: "UI",
                dependencies: ["Domain",
                               "DependencyKit",
                               "Common",
                               "Resources",
                               "NukeUI",
                               "PopupView"
                              ]),
        .target(name: "Common",
                dependencies: ["Domain", "DependencyKit"]),
        .testTarget(
            name: "package-movie-iosTests",
            dependencies: ["package-movie-ios"]),
    ]
)
