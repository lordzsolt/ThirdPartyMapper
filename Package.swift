// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ThirdPartyMapper",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "ThirdPartyMapper", targets: ["ThirdPartyMapper"]),
    ],
    targets: [
        .target(
            name: "ThirdPartyMapper",
            dependencies: []),
        .testTarget(
            name: "ThirdPartyMapperTests",
            dependencies: ["ThirdPartyMapper"]),
    ]
)
