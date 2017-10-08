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
	public func send(serverStoredContent: ServerStoredContent, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(serverStoredContent),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendSticker", payload: payload)
	}

	@discardableResult
	public func forward(message: Message, to receiver: Sendable,
	                    disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.message(chatId: message.chatId, messageId: message.messageId)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "forwardMessage", payload: payload)

	}

	@discardableResult
	public func send(_ sticker: Sticker, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.sticker(fileId: sticker.fileId)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendSticker", payload: payload)
	}

	@discardableResult
	public func send(_ photo: PhotoSize, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.photo(fileId: photo.fileId, caption: caption)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendPhoto", payload: payload)
	}

	@discardableResult
	public func send(_ audio: Audio, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.audio(fileId: audio.fileId, caption: caption)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendAudio", payload: payload)
	}

	@discardableResult
	public func send(_ document: Document, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.document(fileId: document.fileId, caption: caption)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendDocument", payload: payload)
	}


	@discardableResult
	public func send(_ video: Video, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.video(fileId: video.fileId, caption: caption)),
		                             chatId: receiver.chatId,
		                             replyToMessageId: receiver.replyToMessageId,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendVideo", payload: payload)
	}

	@discardableResult
	public func send(_ voice: Voice, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(content: .serverStoredContent(.voice(fileId: voice.fileId, caption: caption)),
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
		                             chatId: chatId, replyToMessageId: nil, disableNotification: nil)
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
			return result!
	}

}
