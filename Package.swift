// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SJFrameSwift",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SJFrameSwift",
            targets: ["SJFrameSwift"]
        )
    ],
    targets: [
        .target(
            name: "SJFrameSwift",
            path: "SJFrameSwift" 
        )
    ]
)
