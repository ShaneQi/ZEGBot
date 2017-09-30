// swift-tools-version:4.0

import PackageDescription

let package = Package(
	name: "ZEGBot",
	products: [
		.library(
			name: "ZEGBot",
			targets: ["ZEGBot"]),
		.executable(
			name: "ZEGBotExample",
			targets: ["ZEGBotExample"])
		],
	dependencies: [],
	targets: [
		.target(
			name: "ZEGBot",
			dependencies: [],
			path: "./Sources"),
		.target(
			name: "ZEGBotExample",
			dependencies: ["ZEGBot"],
			path: "./Example"),
		.testTarget(
			name: "ZEGBotTests",
			dependencies: ["ZEGBot"]),
		]
)
