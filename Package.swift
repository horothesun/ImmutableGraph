// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ImmutableGraph",
    products: [
        .library(
            name: "ImmutableGraph",
            targets: ["ImmutableGraph"]
        ),
    ],
    targets: [
        .target(
            name: "ImmutableGraph",
            dependencies: []
        ),
        .testTarget(
            name: "ImmutableGraphTests",
            dependencies: ["ImmutableGraph"]
        ),
    ]
)
