//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

struct SendingPayload: Codable {

	let chatId: Int
	let replyToMessageId: Int?
	let text: String?
	let fromChatId: Int?
	let messageId: Int?
	let photo: String?
	let caption: String?
	let parseMode: ParseMode?
	let disableWebPagePreview: Bool?
	let disableNotification: Bool?

	enum CodingKeys: String, CodingKey {
		case text, photo, caption
		case chatId = "chat_id"
		case replyToMessageId = "reply_to_message_id"
		case parseMode = "parse_mode"
		case disableWebPagePreview = "disable_web_page_preview"
		case disableNotification = "disable_notification"
		case fromChatId = "from_chat_id"
		case messageId = "message_id"
	}

	init(text: String? = nil,
	     forwardMessage: Message? = nil,
	     photo photoFileId: String? = nil,
	     caption: String? = nil,
	     receiver: Sendable,
	     parseMode: ParseMode? = nil,
	     disableWebPagePreview: Bool? = nil,
	     disableNotification: Bool? = nil) {
		self.chatId = receiver.chatId
		self.fromChatId = forwardMessage?.chatId
		self.messageId = forwardMessage?.messageId
		self.photo = photoFileId
		self.caption = caption
		self.replyToMessageId = receiver.replyToMessageId
		self.text = text
		self.parseMode = parseMode
		self.disableWebPagePreview = disableWebPagePreview
		self.disableNotification = disableNotification
	}

}

public protocol Sendable {

	var chatId: Int { get }
	var replyToMessageId: Int? { get }

}

extension Chat: Sendable {

	public var chatId: Int { return id }
	public var replyToMessageId: Int? { return nil }

}

extension Message: Sendable {

	public var chatId: Int { return self.chat.id }
	public var replyToMessageId: Int? { return messageId }

}
