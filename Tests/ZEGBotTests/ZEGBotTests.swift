import XCTest
import Foundation
@testable import ZEGBot

class ZEGBotTests: XCTestCase {

	static var allTests : [(String, (ZEGBotTests) -> () throws -> Void)] {
		return [
			("testDecoding", testDecoding)
		]
	}

	func testDecoding() {
		let location = try! JSONDecoder().decode(Location.self, from: """
			{
				"latitude": 123.43,
				"longitude": 432.12
			}
		""".data(using: .utf8)!)
		XCTAssert(location.latitude == 123.43, "")
		XCTAssert(location.longitude == 432.12, "")
	}

}
