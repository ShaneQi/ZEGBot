//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//
//

import PerfectCURL

public struct ZEGBot {
	
	private var token: String
	private var urlPrefix: String {
		return "https://api.telegram.org/bot"+token+"/"
	}
	
	init(token: String) {
		
		self.token = token
		
	}
	
	func runWith(handler: ZEGHandler?) {
		var offset = 0
		while true {
			let curl = CURL()
			curl.url = urlPrefix + "getupdates?timeout=60&offset=\(offset)"
			curl.perform(closure: {
				_, _, bodyBytes in
				let updatesString = bodyBytes
					.reduce("", combine: { a, b in a + String(Character(UnicodeScalar(b))) })
			})
		}
		
	}
	
}

public protocol ZEGHandler {

	func handle(update: Update)

}

