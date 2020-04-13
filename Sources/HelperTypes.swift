//
//  HelperTypes.swift
//  ZEGBot
//
//  Created by Shane Qi on 4/5/20.
//

/// Building a `Sendable` object to send message to.
/// When you only want the bot to do things in a standalone manner instead of responding to incoming updates,
/// you won't have the `Sendable` objects (like `Chat`, `Message`, etc.) to pass in sending methods,
/// you can use this struct to build a `Sendable` object.
///
/// e.g. bot.send(message: "hello", to: AnyChat(chatId: MY_CHANNEL_ID))
/////
//public struct AnyChat: Sendable {
//
//	public let chatId: Int
//
//	public init(chatId: Int) {
//		self.chatId = chatId
//	}
//
//}
//
///// Building a `ForwardableMessage` and `Replyable` object to forward or send message to.
/////
///// e.g. bot.forward(message: AnyMessage(chatId: MY_CHAT_ID, messageId: MY_MESSAGE_ID, to: AnyChat(chatId: MY_CHANNEL_ID))
///// e.g. bot.send(message: "hello", to: AnyMessage(chatId: MY_CHANNEL_ID, messageId: MESSAGE_ID))
/////
//public struct AnyMessage: Forwardable, Replyable {
//
//	public let chatId: Int
//	public let messageId: Int
//
//	public init(chatId: Int, messageId: Int) {
//		self.chatId = chatId
//		self.messageId = messageId
//	}
//
//}

indirect enum A: CodingKey, Encodable {

	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .text(let a):
			try container.encode(a)
		case .parseMode(let a):
			try container.encode(a)
		}
	}

	var stringValue: String {
		switch self {
		case .text:
			return "text"
		case .parseMode:
			return "parse_mode"
		}
	}

	init?(stringValue: String) {
		return nil
	}

	var intValue: Int? { return nil }

	init?(intValue: Int) {
		return nil
	}

	case text(String)
	case parseMode(ParseMode)

}
