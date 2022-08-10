// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Operators",
    products: [
        .library(
            name: "Operators",
            targets: ["Operators"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Operators",
            dependencies: [
						]),
				
				// MARK: - Tests
        .testTarget(
            name: "OperatorsTests",
            dependencies: [
							"Operators",
						]),
    ]
)
