// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Operators",
	platforms: [
		.iOS(.v14),
		.macOS(.v11),
	],
	products: [
		.library(
			name: "AsyncOperators",
			targets: ["AsyncOperators"]),
		.library(
			name: "Operators",
			targets: ["Operators"]),
		.library(
			name: "PrecedenceGroups",
			targets: ["PrecedenceGroups"]),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "AsyncOperators",
			dependencies: [
				"FunctionalHelpers",
				"PrecedenceGroups",
			]),
		.target(
			name: "FunctionalHelpers",
			dependencies: [
			]),
		.target(
			name: "Operators",
			dependencies: [
				"FunctionalHelpers",
				"PrecedenceGroups",
			]),
		.target(
			name: "PrecedenceGroups",
			dependencies: [
			]),
		
		// MARK: - Tests
		.testTarget(
			name: "AsyncOperatorsTests",
			dependencies: [
				"AsyncOperators",
			]),
		.testTarget(
			name: "OperatorsTests",
			dependencies: [
				"Operators",
			]),
	]
)
