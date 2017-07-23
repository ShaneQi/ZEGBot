//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import SwiftyJSON
import Foundation
import Dispatch

public struct ZEGBot {

	internal let session = URLSession(configuration: .default)

	internal var urlPrefix: String

	public init(token: String) {
		self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
	}

	public func run(withHandler handler: @escaping UpdateHandler) {
		var offset = 0
		let semaphore = DispatchSemaphore(value: 0)
		while true {
			let task = session.dataTask(with: URL(string: urlPrefix + "getupdates?timeout=60&offset=\(offset)")!) { data, _, _ in
				guard let updatesData = data,
					let updates = ZEGBot.decodeUpdates(from: updatesData) else {
						semaphore.signal()
						return
				}
				if let lastUpdate = updates.last { offset = lastUpdate.updateId + 1 }
				semaphore.signal()
				for update in updates {
					handler(update, self)
				}
			}
			task.resume()
			semaphore.wait()
		}
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

public typealias UpdateHandler = (Update, ZEGBot) -> Void
