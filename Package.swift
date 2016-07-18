import PackageDescription

let package = Package(
	name: "ZEGBot",
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", versions: Version(0,0,0)..<Version(10,0,0))
	]
)
