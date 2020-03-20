//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Dispatch

public typealias UpdateHandler = (Update, ZEGBot) -> Void

public struct ZEGBot {

	internal let session = URLSession(configuration: .default)

	internal let urlPrefix: String

	public init(token: String) {
		self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
	}

	public func run(withHandler handler: @escaping UpdateHandler) throws {
		var offset = 0
		let semaphore = DispatchSemaphore(value: 0)
		var encounterError: Swift.Error?
		while encounterError == nil {
			let task = session.dataTask(
			with: URL(string: urlPrefix + "getupdates?timeout=60&offset=\(offset)")!) { data, _, error in
				guard let data = data else {
					encounterError = error!
					semaphore.signal()
					return
				}
				switch Result<[Update]>.decode(from: data) {
				case .success(let updates):
					if let lastUpdate = updates.last {
						switch lastUpdate {
						case .message(let updateId, _),
							 .editedMessage(let updateId, _),
							 .channelPost(let updateId, _),
							 .callbackQuery(updateId: let updateId, _):
							offset = updateId + 1
						}
					}
					for update in updates {
						handler(update, self)
					}
				case .failure(let error):
					encounterError = error
				}
				semaphore.signal()
			}
			task.resume()
			semaphore.wait()
		}
		throw encounterError!
	}

}
