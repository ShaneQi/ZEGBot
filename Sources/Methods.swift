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
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
			return try performRequest(ofMethod: payload.methodName, payload: payload)
		}

	@discardableResult
	public func forward(
		message: ForwardableMessage, to receiver: Sendable,
		disableNotification: Bool? = nil) throws -> Message {
			let payload = SendingPayload(
				content: .forwardableMessage(chatId: message.chatId, messageId: message.messageId),
				chatId: receiver.chatId,
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: nil)
			return try performRequest(ofMethod: payload.methodName, payload: payload)

		}

	@discardableResult
	public func send(
		resource: Resource, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			let payload = SendingPayload(
				content: .resource(resource),
				chatId: receiver.chatId,
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
			if case .local = resource.location {
				return try performMultipartRequest(ofMethod: payload.methodName, payload: payload)
			} else {
				return try performRequest(ofMethod: payload.methodName, payload: payload)
			}
		}

	@discardableResult
	public func send(
		stickerAt location: Resource.Location, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .sticker, caption: nil),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		photoAt location: Resource.Location, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .photo, caption: caption),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		audioAt location: Resource.Location, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .audio, caption: caption),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		documentAt location: Resource.Location, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .document, caption: caption),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		videoAt location: Resource.Location, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .video, caption: caption),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		voiceAt location: Resource.Location, caption: String? = nil, to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			return try send(
				resource: .init(location: location, type: .voice, caption: caption),
				to: receiver,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
		}

	@discardableResult
	public func send(
		_ location: Location,
		to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			let payload = SendingPayload(
				content: .location(latitude: location.latitude, longitude: location.longitude),
				chatId: receiver.chatId,
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
			return try performRequest(ofMethod: payload.methodName, payload: payload)
		}

	@discardableResult
	public func send(
		_ venue: Venue,
		to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			let payload = SendingPayload(
				content: .venue(
					latitude: venue.location.latitude, longitude: venue.location.longitude,
					title: venue.title, address: venue.address, foursquareId: venue.foursquareId),
				chatId: receiver.chatId,
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
			return try performRequest(ofMethod: payload.methodName, payload: payload)
		}

	@discardableResult
	public func send(
		_ contact: Contact,
		to receiver: Sendable,
		disableNotification: Bool? = nil,
		replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
			let payload = SendingPayload(
				content: .contact(phoneNumber: contact.phoneNumber, firstName: contact.firstName, lastName: contact.lastName),
				chatId: receiver.chatId,
				replyToMessageId: (receiver as? Replyable)?.replyToMessageId,
				disableNotification: disableNotification,
				replyMarkup: replyMarkup)
			return try performRequest(ofMethod: payload.methodName, payload: payload)
		}

	public func send(chatAction: ChatAction, to receiver: Sendable) throws {
		let payload = SendingPayload(
			content: .chatAction(chatAction: chatAction),
			chatId: receiver.chatId, replyToMessageId: nil, disableNotification: nil,
			replyMarkup: nil)
		let _: Bool = try performRequest(ofMethod: payload.methodName, payload: payload)
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

	@discardableResult
	public func editMessage(
		messageId: Int,
		chatId: Int,
		newText: String,
		parseMode: ParseMode? = nil,
		disableWebPagePreview: Bool? = nil) throws -> Message {
			let payload = UpdatingPayload(
				messageId: messageId, chatId: chatId,
				newContent: .text(newText: newText, parseMode: parseMode, disableWebPagePreview: disableWebPagePreview))
			return try performRequest(ofMethod: "editMessageText", payload: payload)
		}

	@discardableResult
	public func editMessage(
		messageId: Int,
		chatId: Int,
		newCaption: String,
		parseMode: ParseMode? = nil) throws -> Message {
			let payload = UpdatingPayload(
				messageId: messageId, chatId: chatId,
				newContent: .caption(newCaption: newCaption, parseMode: parseMode))
			return try performRequest(ofMethod: "editMessageCaption", payload: payload)
		}

}
