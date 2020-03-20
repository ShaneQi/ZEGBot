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
import Dispatch

///  All methods are performed synchronized.
extension ZEGBot {

	@discardableResult
	public func send(
		message text: String, to receiver: Sendable,
		parseMode: ParseMode? = nil,
		disableWebPagePreview: Bool? = nil,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .message(text: text, parseMode: parseMode, disableWebPagePreview: disableWebPagePreview),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: replyMarkup)
		return try performRequest(ofMethod: "sendMessage", payload: payload)
	}

	@discardableResult
	public func forward(
		message: Message, to receiver: Sendable,
		disableNotification: Bool? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.message(chatId: message.chatId, messageId: message.messageId)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "forwardMessage", payload: payload)

	}

	@discardableResult
	public func send(
		_ sticker: Sticker, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.sticker(fileId: sticker.fileId)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendSticker", payload: payload)
	}

	@discardableResult
	public func send(
		_ photo: PhotoSize, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.photo(fileId: photo.fileId, caption: caption)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendPhoto", payload: payload)
	}

	@discardableResult
	public func send(
		_ audio: Audio, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.audio(fileId: audio.fileId, caption: caption)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendAudio", payload: payload)
	}

	@discardableResult
	public func send(
		_ document: Document, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.document(fileId: document.fileId, caption: caption)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendDocument", payload: payload)
	}

	@discardableResult
	public func send(
		_ video: Video, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.video(fileId: video.fileId, caption: caption)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendVideo", payload: payload)
	}

	@discardableResult
	public func send(
		_ voice: Voice, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .serverStoredContent(.voice(fileId: voice.fileId, caption: caption)),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendVoice", payload: payload)
	}

	@discardableResult
	public func sendLocation(
		latitude: Double, longitude: Double, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .location(latitude: latitude, longitude: longitude),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendLocation", payload: payload)
	}

	@discardableResult
	public func sendVenue(
		latitude: Double, longitude: Double,
		title: String, address: String, foursquareId: String? = nil,
		to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .venue(
				latitude: latitude, longitude: longitude,
				title: title, address: address, foursquareId: foursquareId),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendVenue", payload: payload)
	}

	@discardableResult
	public func sendContact(
		phoneNumber: String, firstName: String, lastName: String? = nil,
		to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
		let payload = SendingPayload(
			content: .contact(phoneNumber: phoneNumber, firstName: firstName, lastName: lastName),
			chatId: receiver.chatId,
			replyToMessageId: receiver.replyToMessageId,
			disableNotification: disableNotification,
			replyMarkup: nil)
		return try performRequest(ofMethod: "sendContact", payload: payload)
	}

	public func send(chatAction: ChatAction, toChat chatId: Int) throws {
		let payload = SendingPayload(
			content: .chatAction(chatAction: chatAction),
			chatId: chatId, replyToMessageId: nil, disableNotification: nil,
			replyMarkup: nil)
		let _: Bool = try performRequest(ofMethod: "sendChatAction", payload: payload)
	}

	public func deleteMessage(inChat chatId: Int, messageId: Int) throws {
		let _: Bool = try performRequest(ofMethod: "deleteMessage",
										 payload: ["chat_id": chatId, "message_id": messageId])
	}

	public func getFile(ofId fileId: String) throws -> File {
		return try performRequest(ofMethod: "getFile", payload: ["file_id": fileId])
	}

	public func getChatAdministrators(ofChatWithId chatId: Int) throws -> [ChatMember] {
		return try performRequest(ofMethod: "getChatAdministrators", payload: ["chat_id": chatId])
	}

	public func answerCallbackQuery(
		callbackQueryId: String,
		text: String? = nil,
		showAlert: Bool? = nil,
		url: String? = nil,
		cacheTime: Int? = nil) throws {
		let _: Bool = try performRequest(
			ofMethod: "answerCallbackQuery",
			payload: AnswerCallbackQueryPayload(
				callbackQueryId: callbackQueryId,
				text: text,
				showAlert: showAlert,
				url: url,
				cacheTime: cacheTime))
	}

	public func restrictChatMember(
		chatId: Int,
		userId: Int,
		untilDate: Date? = nil,
		canSendMessages: Bool? = nil,
		canSendMediaMessages: Bool? = nil,
		canSendOtherMessages: Bool? = nil,
		canAddWebPagePreviews: Bool? = nil) throws {
		let _: Bool = try performRequest(
			ofMethod: "restrictChatMember",
			payload: RestrictChatMemberPayload(
				chatId: chatId,
				userId: userId,
				untilDate: untilDate?.unixTimeInt ?? nil,
				canSendMessages: canSendMessages,
				canSendMediaMessages: canSendMediaMessages,
				canSendOtherMessages: canSendOtherMessages,
				canAddWebPagePreviews: canAddWebPagePreviews))
	}

	public func kickChatMember(
		chatId: Int,
		userId: Int,
		untilDate: Date? = nil) throws {
		let _: Bool = try performRequest(
			ofMethod: "kickChatMember",
			payload: KickChatMemberPayload(
				chatId: chatId,
				userId: userId,
				untilDate: untilDate?.unixTimeInt ?? nil))
	}

}

extension ZEGBot {

	private func performRequest<Input, Output>(ofMethod method: String, payload: Input) throws -> Output
		where Input: Encodable, Output: Decodable {
			// Preparing the request.
			let bodyData = try JSONEncoder().encode(payload)
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
			switch result! {
			case .success(let output):
				return output
			case .failure(let error):
				throw error
			}
	}

}

private struct AnswerCallbackQueryPayload: Encodable {

	let callbackQueryId: String
	let text: String?
	let showAlert: Bool?
	let url: String?
	let cacheTime: Int?

	private enum CodingKeys: String, CodingKey {
		case text, url
		case callbackQueryId = "callback_query_id"
		case showAlert = "show_alert"
		case cacheTime = "cache_time"
	}

}

private struct RestrictChatMemberPayload: Encodable {

	let chatId: Int
	let userId: Int
	let untilDate: Int?
	let canSendMessages: Bool?
	let canSendMediaMessages: Bool?
	let canSendOtherMessages: Bool?
	let canAddWebPagePreviews: Bool?

	private enum CodingKeys: String, CodingKey {
		case chatId = "chat_id"
		case userId = "user_id"
		case untilDate = "until_date"
		case canSendMessages = "can_send_messages"
		case canSendMediaMessages = "can_send_media_messages"
		case canSendOtherMessages = "can_send_other_messages"
		case canAddWebPagePreviews = "can_add_web_page_previews"
	}

}

private struct KickChatMemberPayload: Encodable {

	let chatId: Int
	let userId: Int
	let untilDate: Int?

	private enum CodingKeys: String, CodingKey {
		case chatId = "chat_id"
		case userId = "user_id"
		case untilDate = "until_date"
	}

}
