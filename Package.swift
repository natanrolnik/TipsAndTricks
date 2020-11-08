// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TipsAndTricks",
    dependencies: [
        .package(name: "Ink", url: "https://github.com/johnsundell/ink.git", from: "0.1.0")
    ],
    targets: [
        .target(name: "generate",
                dependencies: [
                    .product(name: "Ink", package: "Ink")
                ]
        )
    ]
)
