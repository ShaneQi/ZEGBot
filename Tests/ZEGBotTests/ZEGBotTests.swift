import XCTest
import Foundation
@testable import ZEGBot

class ZEGBotTests: XCTestCase {

	static var allTests : [(String, (ZEGBotTests) -> () throws -> Void)] {
		return [
			("testMessageEntities", testMessageEntities)
		]
	}

	func testMessageEntities() {
		let message1 = try! JSONDecoder().decode(Message.self, from: """
		{
			"message_id": 1502,
			"from": {
				"id": 80548625,
				"is_bot": false,
				"first_name": "Shane",
				"last_name": "Qi",
				"username": "ShaneQi",
				"language_code": "en-US"
			},
			"chat": {
				"id": 80548625,
				"first_name": "Shane",
				"last_name": "Qi",
				"username": "ShaneQi",
				"type": "private"
			},
			"date": 1506745637,
			"text": "@ShaneQi\\n#hashtag\\nhttps://google.com\\nqizengtai@gmail.com\\nbold\\nitalic\\ncode\\nlet hello = \\"world\\"\\n\\ngoogle",
			"entities": [{
				"offset": 0,
				"length": 8,
				"type": "mention"
			}, {
				"offset": 9,
				"length": 8,
				"type": "hashtag"
			}, {
				"offset": 18,
				"length": 18,
				"type": "url"
			}, {
				"offset": 37,
				"length": 19,
				"type": "email"
			}, {
				"offset": 57,
				"length": 4,
				"type": "bold"
			}, {
				"offset": 62,
				"length": 6,
				"type": "italic"
			}, {
				"offset": 69,
				"length": 4,
				"type": "code"
			}, {
				"offset": 74,
				"length": 20,
				"type": "pre"
			}, {
				"offset": 95,
				"length": 6,
				"type": "text_link",
				"url": "https://google.com/"
			}]
		}
		""".data(using: .utf8)!)

		XCTAssert(message1.entities!.count == 9)

		XCTAssert(message1.entities![0].offset == 0)
		XCTAssert(message1.entities![0].length == 8)
		XCTAssert(message1.entities![0].type == .mention)
		XCTAssert(message1.entities![0].url == nil)
		XCTAssert(message1.entities![0].user == nil)

		XCTAssert(message1.entities![1].offset == 9)
		XCTAssert(message1.entities![1].length == 8)
		XCTAssert(message1.entities![1].type == .hashtag)
		XCTAssert(message1.entities![1].url == nil)
		XCTAssert(message1.entities![1].user == nil)

		XCTAssert(message1.entities![2].offset == 18)
		XCTAssert(message1.entities![2].length == 18)
		XCTAssert(message1.entities![2].type == .url)
		XCTAssert(message1.entities![2].url == nil)
		XCTAssert(message1.entities![2].user == nil)

		XCTAssert(message1.entities![3].offset == 37)
		XCTAssert(message1.entities![3].length == 19)
		XCTAssert(message1.entities![3].type == .email)
		XCTAssert(message1.entities![3].url == nil)
		XCTAssert(message1.entities![3].user == nil)

		XCTAssert(message1.entities![4].offset == 57)
		XCTAssert(message1.entities![4].length == 4)
		XCTAssert(message1.entities![4].type == .bold)
		XCTAssert(message1.entities![4].url == nil)
		XCTAssert(message1.entities![4].user == nil)

		XCTAssert(message1.entities![5].offset == 62)
		XCTAssert(message1.entities![5].length == 6)
		XCTAssert(message1.entities![5].type == .italic)
		XCTAssert(message1.entities![5].url == nil)
		XCTAssert(message1.entities![5].user == nil)

		XCTAssert(message1.entities![6].offset == 69)
		XCTAssert(message1.entities![6].length == 4)
		XCTAssert(message1.entities![6].type == .code)
		XCTAssert(message1.entities![6].url == nil)
		XCTAssert(message1.entities![6].user == nil)

		XCTAssert(message1.entities![7].offset == 74)
		XCTAssert(message1.entities![7].length == 20)
		XCTAssert(message1.entities![7].type == .pre)
		XCTAssert(message1.entities![7].url == nil)
		XCTAssert(message1.entities![7].user == nil)

		XCTAssert(message1.entities![8].offset == 95)
		XCTAssert(message1.entities![8].length == 6)
		XCTAssert(message1.entities![8].type == .textLink)
		XCTAssert(message1.entities![8].url == "https://google.com/")
		XCTAssert(message1.entities![8].user == nil)

		let message2 = try! JSONDecoder().decode(Message.self, from: """
		{
			"message_id": 1510,
			"from": {
				"id": 80548625,
				"is_bot": false,
				"first_name": "Shane",
				"last_name": "Qi",
				"username": "ShaneQi",
				"language_code": "en-US"
			},
			"chat": {
				"id": 80548625,
				"first_name": "Shane",
				"last_name": "Qi",
				"username": "ShaneQi",
				"type": "private"
			},
			"date": 1506747809,
			"text": "Max /jake",
			"entities": [{
				"offset": 0,
				"length": 3,
				"type": "text_mention",
				"user": {
					"id": 413748427,
					"is_bot": false,
					"first_name": "Max",
					"last_name": "Lau"
				}
			}, {
				"offset": 4,
				"length": 5,
				"type": "bot_command"
			}]
		}
		""".data(using: .utf8)!)

		XCTAssert(message2.entities!.count == 2)

		XCTAssert(message2.entities![0].offset == 0)
		XCTAssert(message2.entities![0].length == 3)
		XCTAssert(message2.entities![0].type == .textMention)
		XCTAssert(message2.entities![0].url == nil)
		XCTAssert(message2.entities![0].user!.id == 413748427)
		XCTAssert(message2.entities![0].user!.firstName == "Max")
		XCTAssert(message2.entities![0].user!.lastName == "Lau")
		XCTAssert(message2.entities![0].user!.username == nil)

		XCTAssert(message2.entities![1].offset == 4)
		XCTAssert(message2.entities![1].length == 5)
		XCTAssert(message2.entities![1].type == .botCommand)
		XCTAssert(message2.entities![1].url == nil)
		XCTAssert(message2.entities![1].user == nil)
	}

}
