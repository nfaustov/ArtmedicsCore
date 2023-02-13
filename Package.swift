// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ArtmedicsCore",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "ArtmedicsCore",
            targets: ["ArtmedicsCore"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ArtmedicsCore",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "ArtmedicsCoreTests",
            dependencies: ["ArtmedicsCore"]
        )
    ]
)
