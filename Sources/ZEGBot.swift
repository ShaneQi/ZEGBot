//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import cURL
import PerfectCURL
import PerfectThread
import SwiftyJSON

public struct ZEGBot {
	
	private var token: String
	internal var urlPrefix: String
	
	public init(token: String) {
		self.token = token
		self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
	}
	
	
	public func run(with handler: @escaping (Update, ZEGBot) -> Void ) {
		
		let curl = CURL()
		var offset = 0
		
		while true {
			
			curl.url = urlPrefix + "getupdates?timeout=60&offset=\(offset)"
			
			let responseBodyString = curl.performFully().2.reduce("", { a, b in a + String(UnicodeScalar(b)) })
			
			guard let updates = ZEGBot.decodeUpdates(from: responseBodyString) else { continue }
			
			if let lastUpdate = updates.last { offset = lastUpdate.update_id + 1 }
			
			for update in updates {
				Threading.dispatch {
					handler(update, self)
				}
			}
			
		}
		
	}
	
	public func run(with handler: ZEGHandler) {
		run(with: handler.handle)
	}
	
	
}

extension ZEGBot {
	
	/* For getUpdates. */
	static func decodeUpdates(from jsonString: String) -> [Update]? {
		
		return Update.array(from: JSON.parse(string: jsonString))
		
	}
	
	/* For webhook. */
	static func decodeUpdate(from jsonString: String) -> Update? {
		
		return Update(from: JSON.parse(string: jsonString))
		
	}
	
}

public protocol ZEGHandler {
	
	func handle(update: Update, bot: ZEGBot)
	
}
