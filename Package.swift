// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BirdMaster",
    platforms: [
        .iOS(.v17)
    ],
    targets: [
        .testTarget(
            name: "BirdMasterSmokeTests",
            dependencies: [],
            path: "Tests/BirdMasterSmokeTests"
        )
    ]
)
