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
import Dispatch

///  All methods are performed synchronized.
extension ZEGBot {

	@discardableResult
	public func send(message text: String, to receiver: Sendable,
	                 parseMode: ParseMode? = nil,
	                 disableWebPagePreview: Bool? = nil,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .message(text: text, parseMode: parseMode, disableWebPagePreview: disableWebPagePreview),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendMessage", payload: payload)
	}

	@discardableResult
	public func forward(message: Message, to receiver: Sendable,
	                    disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .forwardMessage(chatId: message.chatId, messageId: message.messageId),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "forwardMessage", payload: payload)

	}

	@discardableResult
	public func send(sticker fileId: String, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .sticker(fileId: fileId),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendSticker", payload: payload)
	}

	@discardableResult
	public func send(photo fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .photo(fileId: fileId, caption: caption),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendPhoto", payload: payload)
	}

	@discardableResult
	public func send(audio fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .audio(fileId: fileId, caption: caption),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendAudio", payload: payload)
	}

	@discardableResult
	public func send(document fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .document(fileId: fileId, caption: caption),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendDocument", payload: payload)
	}


	@discardableResult
	public func send(video fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .video(fileId: fileId, caption: caption),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendVideo", payload: payload)
	}

	@discardableResult
	public func send(voice fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .voice(fileId: fileId, caption: caption),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendVoice", payload: payload)
	}

	@discardableResult
	public func sendLocation(latitude: Double, longitude: Double, to receiver: Sendable,
	                         disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .location(latitude: latitude, longitude: longitude),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendLocation", payload: payload)
	}

	@discardableResult
	public func sendVenue(latitude: Double, longitude: Double,
	                      title: String, address: String, foursquareId: String? = nil,
	                      to receiver: Sendable,
	                      disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .venue(latitude: latitude, longitude: longitude, title: title, address: address, foursquareId: foursquareId),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendVenue", payload: payload)
	}

	@discardableResult
	public func sendContact(phoneNumber: String, firstName: String, lastName: String? = nil,
	                        to receiver: Sendable,
	                        disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .contact(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendContact", payload: payload)
	}

	@discardableResult
	public func send(chatAction: ChatAction, toChat chatId: Int) -> Result<Bool> {
		let payload = SendingPayload(content: .chatAction(chatAction: chatAction),
		                             chatId: chatId)
		return performRequest(ofMethod: "sendChatAction", payload: payload)
	}

	public func getFile(ofId fileId: String) -> Result<File> {
		return performRequest(ofMethod: "getFile", payload: ["file_id": fileId])
	}

}

extension ZEGBot {

	private func performRequest<Input, Output>(ofMethod method: String, payload: Input) -> Result<Output>
		where Input: Encodable, Output: Decodable {
			// Preparing the request.
			let bodyData = (try? JSONEncoder().encode(payload))!
			let semaphore = DispatchSemaphore(value: 0)
			var request = URLRequest(url: URL(string: urlPrefix + method)!)
			request.httpMethod = "POST"
			request.httpBody = bodyData
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")

			// Perform the request.
			var result: Result<Data>?
			let task = URLSession(configuration: .default).dataTask(with: request) { data, _, error in
				if data != nil {
					result = .success(data!)
				} else {
					result = .failure(error!)
				}
				semaphore.signal()
			}
			task.resume()
			semaphore.wait()

			// Handle the response.
			switch result! {
			case .success(let data):
				do {
					let messageResult = try JSONDecoder().decode(TelegramResult<Output>.self, from: data).result
					switch messageResult {
					case .success(let message): return .success(message)
					case .failure(let error): throw error
					}
				} catch(let error) {
					return .failure(error)
				}
			case .failure(let error):
				return .failure(error)
			}
	}

}

struct TelegramResult<T>: Decodable where T: Decodable {

	let value: T?
	let description: String?

	enum CodingKeys: String, CodingKey {
		case description
		case value = "result"
	}

	var result: Result<T> {
		if let value = value {
			return .success(value)
		} else {
			return .failure(Error.telegram(description))
		}
	}

}
