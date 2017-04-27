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
import SwiftyJSON
import Foundation

public struct ZEGBot {

	internal var urlPrefix: String
	
	public init(token: String) {
		self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
	}

	public func run(with handler: @escaping ZEGUpdateHandle ) {
		
		let curl = CURL()
		var offset = 0
		
		while true {
			
			curl.url = urlPrefix + "getupdates?timeout=60&offset=\(offset)"
			
			guard let updates = ZEGBot.decodeUpdates(from: Data(bytes: curl.performFully().2)) else { continue }
			
			if let lastUpdate = updates.last { offset = lastUpdate.updateId + 1 }
			
			for update in updates {
				handler(update, self)
			}
			
		}
		
	}
	
	public func run(with handler: ZEGUpdateHandler) {
		run(with: handler.handle)
	}
	
	
}

extension ZEGBot {
	
	/* For getUpdates. */
	static func decodeUpdates(from jsonData: Data) -> [Update]? {
		
		return Update.array(from: JSON(data: jsonData)[PARAM.RESULT])
		
	}
	
	/* For webhook. */
	static func decodeUpdate(from jsonData: Data) -> Update? {
		
		return Update(from: JSON(data: jsonData)[PARAM.RESULT])
		
	}
	
}

public typealias ZEGUpdateHandle = (Update, ZEGBot) -> Void

public protocol ZEGUpdateHandler {
	
	func handle(update: Update, bot: ZEGBot)
	
}
