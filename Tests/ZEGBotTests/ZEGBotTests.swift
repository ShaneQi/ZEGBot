import XCTest
@testable import ZEGBot

class ZEGBotTests: XCTestCase {

	static var allTests : [(String, (ZEGBotTests) -> () throws -> Void)] {
		return [
			("testStringToBytes", testStringToBytes),
		]
	}

	func testStringToBytes() {
		let bytes: [UInt8] = [104, 101, 108, 108, 111, 33]
		XCTAssertEqual("hello!".bytes(), bytes)
	}

	func testDictionaryAppending() {
		var dictionary: [String: Any] = ["key1": 1]
		let additionalDictionary: [String: Any] = ["key1": "value1", "key2": "value2"]
		let additionalOptionalDictionary: [String: Any?] = ["key1": nil, "key3": 3]

		dictionary.append(contentOf: additionalDictionary)
		XCTAssertEqual(dictionary.keys.count, 2)
		XCTAssertEqual(dictionary["key1"] as! String, "value1")

		dictionary.append(contentOf: additionalOptionalDictionary)
		XCTAssertEqual(dictionary["key1"] as! String, "value1")
		XCTAssertEqual(dictionary["key3"] as! Int, 3)
	}

}
