//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

struct SendingPayload: Encodable {

	let content: Content
	let chatId: Int
	let replyToMessageId: Int?
	let disableNotification: Bool?

	enum Content {
		case message(text: String, parseMode: ParseMode?, disableWebPagePreview: Bool?)
		case forwardMessage(chatId: Int, messageId: Int)
		case photo(fileId: String, caption: String?)
		case sticker(fileId: String)
	}

	enum CodingKeys: String, CodingKey {

		case chatId = "chat_id"
		case replyToMessageId = "reply_to_message_id"
		case disableNotification = "disable_notification"

		// sendMessage
		case text
		case parseMode = "parse_mode"
		case disableWebPagePreview = "disable_web_page_preview"

		// forwardMessage
		case fromChatId = "from_chat_id"
		case messageId = "message_id"

		// sendPhoto
		case photo, caption

		// sendSticker
		case sticker
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(chatId, forKey: .chatId)
		if let replyToMessageId = replyToMessageId {
			try container.encode(replyToMessageId, forKey: .replyToMessageId)
		}
		if let disableNotification = disableNotification {
			try container.encode(disableNotification, forKey: .disableNotification)
		}

		switch content {
		case .message(text: let text, parseMode: let parseMode, disableWebPagePreview: let disableWebPagePreview):
			try container.encode(text, forKey: .text)
			if let parseMode = parseMode { try container.encode(parseMode, forKey: .parseMode) }
			if let disableWebPagePreview = disableWebPagePreview {
				try container.encode(disableWebPagePreview, forKey: .disableWebPagePreview)
			}
		case .forwardMessage(chatId: let chatId, messageId: let messageId):
			try container.encode(chatId, forKey: .fromChatId)
			try container.encode(messageId, forKey: .messageId)
		case .photo(fileId: let fileId, caption: let caption):
			try container.encode(fileId, forKey: .photo)
			if let caption = caption { try container.encode(caption, forKey: .caption) }
		case .sticker(fileId: let fileId):
			try container.encode(fileId, forKey: .sticker)
		}
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
