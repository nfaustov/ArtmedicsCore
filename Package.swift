// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ArtmedicsCore",
    platforms: [.iOS(.v16), .macOS(.v13)],
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
