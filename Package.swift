// swift-tools-version:5.1

import PackageDescription

let package = Package(
	name: "LoadingState",
	products: [
		.library(
			name: "LoadingState",
			targets: ["LoadingState"]
		)
	],
	targets: [
		.target(name: "LoadingState"),
		.testTarget(
			name: "LoadingStateTests",
			dependencies: ["LoadingState"]
		)
	]
)
