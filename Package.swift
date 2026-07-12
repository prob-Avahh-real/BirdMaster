// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BirdMaster",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(
            name: "BirdMaster",
            targets: ["BirdMaster"]
        )
    ],
    targets: [
        .executableTarget(
            name: "BirdMaster",
            path: "BirdMaster"
        )
    ]
)
