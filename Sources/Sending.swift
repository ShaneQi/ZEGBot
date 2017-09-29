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
	let parseMode: ParseMode?
	let disableWebPagePreview: Bool?
	let disableNotification: Bool?

	enum CodingKeys: String, CodingKey {
		case text
		case chatId = "chat_id"
		case replyToMessageId = "reply_to_message_id"
		case parseMode = "parse_mode"
		case disableWebPagePreview = "disable_web_page_preview"
		case disableNotification = "disable_notification"
	}

	init(text: String? = nil,
	     receiver: Sendable,
	     parseMode: ParseMode? = nil,
	     disableWebPagePreview: Bool? = nil,
	     disableNotification: Bool? = nil) {
		self.chatId = receiver.chatId
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

//public protocol Identifiable {
//
//	var identifier: [String: Any] { get }
//	var sendingMethod: String { get }
//
//}
//
//extension PhotoSize: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.PHOTO: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_PHOTO }
//
//}
//
//extension Audio: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.AUDIO: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_AUDIO }
//
//}
//
//extension Document: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.DOCUMENT: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_DOCUMENT }
//
//}
//
//extension Sticker: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.STICKER: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_STICKER }
//
//}
//
//extension Video: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.VIDEO: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_VIDEO }
//
//}
//
//extension Voice: Identifiable {
//
//	public var identifier: [String: Any] {
//		return [ZEGBot.PARAM.VOICE: self.fileId]
//	}
//
//	public var sendingMethod: String { return ZEGBot.PARAM.SEND_VOICE }
//
//}
