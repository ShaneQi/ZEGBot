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
import Dispatch

public typealias UpdateHandler = (Result<Update>, ZEGBot) -> Void

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
			let task = session.dataTask(with: URL(string: urlPrefix + "getupdates?timeout=60&offset=\(offset)")!) { data, _, error in
				guard let data = data else {
					handler(.failure(error!), self)
					semaphore.signal()
					return
				}
				switch Result<[Update]>.decode(from: data) {
				case .success(let updates):
					if let lastUpdate = updates.last { offset = lastUpdate.updateId + 1 }
					for update in updates {
						handler(.success(update), self)
					}
				case .failure(let error): handler(.failure(error), self)
				}
				semaphore.signal()
			}
			task.resume()
			semaphore.wait()
		}
	}

}
