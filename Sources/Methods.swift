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
		let payload = SendingPayload(text: text,
		                             receiver: receiver,
		                             parseMode: parseMode,
		                             disableWebPagePreview: disableWebPagePreview,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendMessage", payload: payload)
	}

	@discardableResult
	public func forward(message: Message, to receiver: Sendable,
	                    disableNotification: Bool? = nil) -> Result<Message> {
		let payload = SendingPayload(forwardMessage: message,
		                             receiver: receiver,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "forwardMessage", payload: payload)

	}

	@discardableResult
	public func send(photo fileId: String, caption: String? = nil, to receiver: Sendable,
	                 disableNotification: Bool = false) -> Result<Message> {
		let payload = SendingPayload(photo: fileId,
		                             caption: caption,
		                             receiver: receiver,
		                             disableNotification: disableNotification)
		return performRequest(ofMethod: "sendPhoto", payload: payload)
	}
//
//	@discardableResult
//	public func send(audio: Audio, to receiver: Sendable,
//	                 disableNotification: Bool = false) -> Message? {
//
//		var options = [String: Any]()
//
//		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
//
//		return send(contentOnServer: audio, to: receiver, options: options)
//
//	}
//
//	@discardableResult
//	public func send(document: Document, to receiver: Sendable,
//	                 disableNotification: Bool = false,
//	                 caption: String? = nil) -> Message? {
//
//		var options = [String: Any]()
//
//		options[PARAM.CAPTION] = caption
//		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
//
//		return send(contentOnServer: document, to: receiver, options: options)
//
//	}
//
//	@discardableResult
//	public func send(sticker: Sticker, to receiver: Sendable,
//	                 disableNotification: Bool = false) -> Message? {
//
//		var options = [String: Any]()
//
//		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
//
//		return send(contentOnServer: sticker, to: receiver, options: options)
//
//	}
//
//	@discardableResult
//	public func send(video: Video, to receiver: Sendable,
//	                 disableNotification: Bool = false) -> Message? {
//
//		var options = [String: Any]()
//
//		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
//
//		return send(contentOnServer: video, to: receiver, options: options)
//
//	}
//
//	@discardableResult
//	public func send(voice: Voice, to receiver: Sendable,
//	                 disableNotification: Bool = false) -> Message? {
//
//		var options = [String: Any]()
//
//		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
//
//		return send(contentOnServer: voice, to: receiver, options: options)
//
//	}
//
//	@discardableResult
//	public func sendLocation(latitude: Double, longitude: Double, to receiver: Sendable,
//	                         disableNotification: Bool = false) -> Message? {
//
//		var payload: [String: Any] = [
//			PARAM.LATITUDE: latitude,
//			PARAM.LONGITUDE: longitude
//		]
//
//		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
//		payload.append(contentOf: receiver.receiverIdentifier)
//
//		guard let responseJSON = perform(method: PARAM.SEND_LOCATION, payload: payload) else {
//			return nil
//		}
//
//		return Message(from: responseJSON[PARAM.RESULT])
//	}
//
//	@discardableResult
//	public func sendVenue(latitude: Double, longitude: Double,
//	                      title: String, address: String, foursquareId: String? = nil,
//	                      to receiver: Sendable,
//	                      disableNotification: Bool = false) -> Message? {
//
//		var payload: [String: Any] = [
//			PARAM.LATITUDE: latitude,
//			PARAM.LONGITUDE: longitude,
//			PARAM.TITLE: title,
//			PARAM.ADDRESS: address
//		]
//		let optionalPayload: [String: Any?] = [
//			PARAM.FOURSQUARE_ID: foursquareId
//		]
//		payload.append(contentOf: optionalPayload)
//
//		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
//		payload.append(contentOf: receiver.receiverIdentifier)
//
//		guard let responseJSON = perform(method: PARAM.SEND_VENUE, payload: payload) else {
//			return nil
//		}
//
//		return Message(from: responseJSON[PARAM.RESULT])
//
//	}
//
//	@discardableResult
//	public func sendContact(phoneNumber: String, lastName: String, firstName: String? = nil,
//	                        to receiver: Sendable,
//	                        disableNotification: Bool = false) -> Message? {
//
//		var payload: [String: Any] = [
//			PARAM.PHONE_NUMBER: phoneNumber,
//			PARAM.LAST_NAME: lastName
//		]
//		let optionalPayload: [String: Any?] = [
//			PARAM.FIRST_NAME: firstName
//		]
//		payload.append(contentOf: optionalPayload)
//
//		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
//		payload.append(contentOf: receiver.receiverIdentifier)
//
//		guard let responseJSON = perform(method: PARAM.SEND_CONTACT, payload: payload) else {
//			return nil
//		}
//
//		return Message(from: responseJSON[PARAM.RESULT])
//
//	}
//
//	public func send(chatAction: ChatAction, to receiver: Sendable) {
//
//		var payload: [String: Any] = [
//			PARAM.ACTION: chatAction.rawValue
//		]
//
//		payload.append(contentOf: receiver.receiverIdentifier)
//
//		let _ = perform(method: PARAM.SEND_CHAT_ACTION, payload: payload)
//
//	}
//
//	public func getFile(ofId fileId: String) -> File? {
//
//		let payload: [String: Any] = [
//			PARAM.FILE_ID: fileId
//		]
//
//		guard let responseJSON = perform(method: PARAM.GET_FILE, payload: payload) else {
//			return nil
//		}
//
//		return File(from: responseJSON[PARAM.RESULT])
//
//	}
//
}

extension ZEGBot {

	private func performRequest<Input, Output>(ofMethod method: String, payload: Input) -> Result<Output>
		where Input: Codable, Output: Codable {
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

struct TelegramResult<T>: Codable where T: Codable {

	let isOk: Bool
	let value: T?
	let description: String?

	enum CodingKeys: String, CodingKey {
		case description
		case isOk = "ok"
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
