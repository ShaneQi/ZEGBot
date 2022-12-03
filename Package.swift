// swift-tools-version:5.7

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
		.executableTarget(
			name: "ZEGBotExample",
			dependencies: ["ZEGBot"],
			path: "./Example"),
		.testTarget(
			name: "ZEGBotTests",
			dependencies: ["ZEGBot"])
		],
	swiftLanguageVersions: [.v5]
)
