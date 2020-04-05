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
///
/// discussion: if `replyToMessageId` isn't nil, the receiver will be the message of the chat
/// (new message will be sent in a replying manner).
public struct AnyChat: Sendable, Replyable {

	public let chatId: Int
	public let replyToMessageId: Int?

	public init(chatId: Int, replyToMessageId: Int? = nil) {
		self.chatId = chatId
		self.replyToMessageId = replyToMessageId
	}

}

/// Building a `ForwardableMessage` object to forward.
///
/// e.g. bot.forward(message: AnyMessage(chatId: MY_CHAT_ID, messageId: MY_MESSAGE_ID, to: AnyChat(chatId: MY_CHANNEL_ID))
public struct AnyMessage: ForwardableMessage {

	public let chatId: Int
	public let messageId: Int

	public init(chatId: Int, messageId: Int) {
		self.chatId = chatId
		self.messageId = messageId
	}

}
