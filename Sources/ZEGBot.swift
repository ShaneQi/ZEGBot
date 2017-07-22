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

public struct ZEGBot {

	internal let session = URLSession(configuration: .default)

	internal var urlPrefix: String

	public init(token: String) {
		self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
	}

	public func run(withHandler handler: @escaping UpdateHandler) {
		getUpdates(offset: 0, handler: handler)
		while true {
			if readLine() == "stop" { return }
		}
	}

	private func getUpdates(offset: Int, handler: @escaping UpdateHandler) {
		let task = session.dataTask(with: URL(string: urlPrefix + "getupdates?timeout=60&offset=\(offset)")!) { data, _, error in
			guard let updates = ZEGBot.decodeUpdates(from: data!) else { return }
			for update in updates {
				handler(update, self)
			}
			var newOffset = offset
			if let lastUpdate = updates.last { newOffset = lastUpdate.updateId + 1 }
			self.getUpdates(offset: newOffset, handler: handler)
		}
		task.resume()
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
