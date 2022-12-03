//
//  Methods.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ZEGBot {

	func performRequest<Input, Output>(ofMethod method: String, payload: Input) throws -> Output
	where Input: Encodable, Output: Decodable {
		// Preparing the request.
		let bodyData = try JSONEncoder().encode(payload)
		var request = URLRequest(url: URL(string: urlPrefix + method)!)
		request.httpMethod = "POST"
		request.httpBody = bodyData
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		return try performRequest(request)
	}

	func performMultipartRequest<Input, Output>(ofMethod method: String, payload: Input) throws -> Output
	where Input: MultipartEncodable, Output: Decodable {
		// Preparing the request.
		let boundary = UUID().uuidString
		var request = URLRequest(url: URL(string: urlPrefix + method)!)
		request.httpMethod = "POST"
		let data = try payload.encode(withBoundary: boundary)
		request.httpBody = data
		request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

		return try performRequest(request)
	}

	func performRequest<Output>(_ request: URLRequest) throws -> Output where Output: Decodable {
		// Perform the request.
		let semaphore = DispatchSemaphore(value: 0)
		var result: Result<Output>?
		let task = URLSession(configuration: .default).dataTask(with: request) { data, _, error in
			if let data = data {
				result = Result<Output>.decode(from: data)
			} else {
				result = .failure(error!)
			}
			semaphore.signal()
		}
		task.resume()
		semaphore.wait()
		switch result! {
		case .success(let output):
			return output
		case .failure(let error):
			throw error
		}
	}

}

struct AnswerCallbackQueryPayload: Encodable {

	let callbackQueryId: String
	let text: String?
	let showAlert: Bool?
	let url: String?
	let cacheTime: Int?

	enum CodingKeys: String, CodingKey {
		case text, url
		case callbackQueryId = "callback_query_id"
		case showAlert = "show_alert"
		case cacheTime = "cache_time"
	}

}

struct RestrictChatMemberPayload: Encodable {

	let chatId: Int
	let userId: Int
	let untilDate: Int?
	let canSendMessages: Bool?
	let canSendMediaMessages: Bool?
	let canSendOtherMessages: Bool?
	let canAddWebPagePreviews: Bool?

	enum CodingKeys: String, CodingKey {
		case chatId = "chat_id"
		case userId = "user_id"
		case untilDate = "until_date"
		case canSendMessages = "can_send_messages"
		case canSendMediaMessages = "can_send_media_messages"
		case canSendOtherMessages = "can_send_other_messages"
		case canAddWebPagePreviews = "can_add_web_page_previews"
	}

}

struct KickChatMemberPayload: Encodable {

	let chatId: Int
	let userId: Int
	let untilDate: Int?

	enum CodingKeys: String, CodingKey {
		case chatId = "chat_id"
		case userId = "user_id"
		case untilDate = "until_date"
	}

}

protocol MultipartEncodable {

	func encode(withBoundary boundary: String) throws -> Data

}
