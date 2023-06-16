// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DealiDesignKit",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DealiDesignKit",
            targets: ["DealiDesignKit"]),
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/layoutBox/FlexLayout.git", from: "1.3.18"),
        .package(url: "https://github.com/layoutBox/PinLayout", from: "1.10.4"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DealiDesignKit",
            dependencies: ["SnapKit", "Then", "FlexLayout", "PinLayout", "RxSwift"], //, .product(name: "RxCocoa", package: "RxSwift")],
            resources: [.process("Resources/PretendardFonts")]
            ),
        
        .testTarget(
            name: "DealiDesignKitTests",
            dependencies: ["DealiDesignKit"]),
    ]
)
