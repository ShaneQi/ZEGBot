import XCTest
@testable import ZEGBot

class ZEGBotTests: XCTestCase {
	
	let bot = ZEGBot(token: secret)
	
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		bot.run(with: {
			update, bot in
			
			guard update.message?.text == "start test" else { return }
			let chat = update.message!.chat
			let message = update.message!
			let receivers: [Sendable] = [chat, message]
			let parseModes: [ParseMode?] = [ParseMode.HTML, ParseMode.MARKDOWN, nil]
			let bools: [Bool] = [true, false]
			
 			receivers.forEach({ receiver in
				parseModes.forEach({ parseMode in
					bools.forEach({ disableNotification in
						bools.forEach({ disablePreview in
							bot.send(message: "regular: *BOLD* <a href=\"https://google.com\">link</a> \n reply: \(receiver is Message) - \(parseMode?.rawValue) - disableNotification: \(disableNotification) - disablePreview: \(disablePreview)", to: receiver, parseMode: parseMode, disableWebPagePreview: disablePreview, disableNotification: disableNotification)
						})
					})
				})
			})

		})
	}
	
	
	static var allTests : [(String, (ZEGBotTests) -> () throws -> Void)] {
		return [
			("testExample", testExample),
		]
	}
}
