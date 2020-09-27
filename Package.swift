// swift-tools-version:5.3

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
