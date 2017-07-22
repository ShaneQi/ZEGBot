import PackageDescription

let package = Package(
	name: "ZEGBot",
	dependencies: [
		.Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 15)
	]
)
