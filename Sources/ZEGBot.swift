//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectCURL

public struct ZEGBot {
	
	private var token: String
	private var urlPrefix: String { return "https://api.telegram.org/bot"+token+"/" }
	
	init(token: String) { self.token = token }
	
	func runWith(handler: ZEGHandler) {

		let curl = CURL()
		var offset = 0

		while true {

			curl.url = urlPrefix + "getupdates?timeout=60&offset=\(offset)"
			
			let responseBodyString = curl.performFully().2.reduce("", combine: { a, b in a + String(UnicodeScalar(b)) })
			
			guard let updates = ZEGDecoder.decodeUpdates(from: responseBodyString) else { continue }

			if let lastUpdate = updates.last { offset = lastUpdate.update_id + 1 }
			
			for update in updates { handler.handle(update) }
			
		}
		
	}
	
}

public protocol ZEGHandler {

	func handle(_ update: Update)

}

