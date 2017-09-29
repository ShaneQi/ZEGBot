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
	dependencies: [
		.package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", from: Version(15, 0, 6))
	],
	targets: [
		.target(
			name: "ZEGBot",
			dependencies: ["SwiftyJSON"],
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
