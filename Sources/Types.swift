//
//  Types.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import Foundation

public enum Update: Decodable {

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let updateId = try container.decode(Int.self, forKey: .updateId)
		if container.contains(.message) {
			self = .message(updateId: updateId, message: try container.decode(Message.self, forKey: .message))
		} else if container.contains(.editedMessage) {
			self = .editedMessage(updateId: updateId, message: try container.decode(Message.self, forKey: .editedMessage))
		} else if container.contains(.channelPost) {
			self = .channelPost(updateId: updateId, message: try container.decode(Message.self, forKey: .channelPost))
		} else if container.contains(.callbackQuery) {
			self = .callbackQuery(updateId: updateId, query: try container.decode(CallbackQuery.self, forKey: .callbackQuery))
		} else {
			throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: """
				Failed to find value under keys: \
				"\(CodingKeys.message.rawValue)", \
				"\(CodingKeys.editedMessage.rawValue)" or \
				"\(CodingKeys.channelPost.rawValue)".
				"""))
		}
	}

	private enum CodingKeys: String, CodingKey {
		case message
		case updateId = "update_id"
		case editedMessage = "edited_message"
		case channelPost = "channel_post"
		case callbackQuery = "callback_query"
	}

	case message(updateId: Int, message: Message)
	case editedMessage(updateId: Int, message: Message)
	case channelPost(updateId: Int, message: Message)
	case callbackQuery(updateId: Int, query: CallbackQuery)

	public var message: Message? {
		if case .message(_, let message) = self {
			return message
		} else {
			return nil
		}
	}

	public var editedMessage: Message? {
		if case .editedMessage(_, let message) = self {
			return message
		} else {
			return nil
		}
	}

	public var channelPost: Message? {
		if case .channelPost(_, let message) = self {
			return message
		} else {
			return nil
		}
	}

	public var callbackQuery: CallbackQuery? {
		if case .callbackQuery(_, let query) = self {
			return query
		} else {
			return nil
		}
	}

}

public class Message: Codable {

	public let messageId: Int
	public let date: Int
	public let chat: Chat

	/* Optional. */
	public let from: User?
	public let forwardFrom: User?
	public let forwardFromChat: Chat?
	public let forwardDate: Int?
	public let replyToMessage: Message?
	public let editDate: Int?
	public let mediaGroupId: String?
	public let text: String?
	public let entities: [MessageEntity]?
	public let audio: Audio?
	public let document: Document?
	public let photo: [PhotoSize]?
	public let sticker: Sticker?
	public let video: Video?
	public let voice: Voice?
	public let caption: String?
	public let contact: Contact?
	public let location: Location?
	public let venue: Venue?
	public let newChatMember: User?
	public let leftChatMember: User?
	public let newChatTitle: String?
	public let newChatPhoto: [PhotoSize]?
	public let deleteChatPhoto: Bool?
	public let groupChatCreated: Bool?
	public let supergroupChatCreated: Bool?
	public let channelChatCreated: Bool?
	public let migrateToChatId: Int?
	public let migrateFromChatId: Int?
	public let pinnedMessage: Message?

	private enum CodingKeys: String, CodingKey {
		case date, chat, from, text, entities
		case audio, document, photo, sticker, video, voice, caption, contact, location, venue
		case messageId = "message_id"
		case forwardFrom = "forward_from"
		case forwardFromChat = "forward_from_chat"
		case forwardDate = "forward_date"
		case replyToMessage = "reply_to_message"
		case editDate = "edit_date"
		case newChatMember = "new_chat_member"
		case leftChatMember = "left_chat_member"
		case newChatTitle = "new_chat_title"
		case newChatPhoto = "new_chat_photo"
		case deleteChatPhoto = "delete_chat_photo"
		case groupChatCreated = "group_chat_created"
		case supergroupChatCreated = "supergroup_chat_created"
		case channelChatCreated = "channel_chat_created"
		case migrateToChatId = "migrate_to_chat_id"
		case migrateFromChatId = "migrate_from_chat_id"
		case pinnedMessage = "pinned_message"
		case mediaGroupId = "media_group_id"
	}

}

public struct Chat: Codable {

	public let id: Int
	public let type: StructType

	/* Optional. */
	public let title: String?
	public let username: String?
	public let firstName: String?
	public let lastName: String?

	public enum StructType: String, Codable {
		case `private`, group, supergroup, channel
	}

	private enum CodingKeys: String, CodingKey {
		case id, type, title, username
		case firstName = "first_name"
		case lastName = "last_name"
	}

}

public struct User: Codable {

	public let id: Int
	public let firstName: String
	public let isBot: Bool

	/* OPTIONAL. */
	public let lastName: String?
	public let username: String?

	private enum CodingKeys: String, CodingKey {
		case id, username
		case firstName = "first_name"
		case lastName = "last_name"
		case isBot = "is_bot"
	}

}

public struct MessageEntity: Codable {

	public let type: StructType
	public let offset: Int
	public let length: Int

	/* OPTIONAl. */
	public let url: String?
	public let user: User?

	public enum StructType: String, Codable {
		case mention, hashtag, url, email, bold, italic, code, pre
		case botCommand = "bot_command"
		case textLink = "text_link"
		case textMention = "text_mention"
		case cashtag
		case phoneNumber = "phone_number"
	}

}

public struct Audio: Codable {

	public let fileId: String
	public let duration: Int

	/* OPTIONAL. */
	public let performer: String?
	public let title: String?
	public let mimeType: String?
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case duration, performer, title
		case fileId = "file_id"
		case mimeType = "mime_type"
		case fileSize = "file_size"
	}

}

public struct Document: Codable {

	public let fileId: String

	/* OPTIONAL. */
	public let thumb: PhotoSize?
	public let fileName: String?
	public let mimeType: String?
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case thumb
		case fileId = "file_id"
		case fileName = "file_name"
		case mimeType = "mime_type"
		case fileSize = "file_size"
	}

}

public struct PhotoSize: Codable {

	public let fileId: String
	public let width: Int
	public let height: Int

	/* Optional. */
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case width, height
		case fileId = "file_id"
		case fileSize = "file_size"
	}

}

public struct Sticker: Codable {

	public let fileId: String
	public let width: Int
	public let height: Int

	/* Optional. */
	public let thumb: PhotoSize?
	public let emoji: String?
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case width, height, thumb, emoji
		case fileId = "file_id"
		case fileSize = "file_size"
	}

}

public struct Video: Codable {

	public let fileId: String
	public let width: Int
	public let height: Int
	public let duration: Int

	/* OPTIONAL. */
	public let thumb: PhotoSize?
	public let mimeType: String?
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case width, height, duration, thumb
		case fileId = "file_id"
		case mimeType = "mime_type"
		case fileSize = "file_size"
	}

}

public struct Voice: Codable {

	public let fileId: String
	public let duration: Int

	/* Optional. */
	public let mimeType: String?
	public let fileSize: Int?

	private enum CodingKeys: String, CodingKey {
		case duration
		case fileId = "file_id"
		case mimeType = "mime_type"
		case fileSize = "file_size"
	}

}

public struct Contact: Codable {

	public let phoneNumber: String
	public let firstName: String

	/* OPTIONAL. */
	public let lastName: String?
	public let userId: Int?

	private enum CodingKeys: String, CodingKey {
		case phoneNumber = "phone_number"
		case firstName = "first_name"
		case lastName = "last_name"
		case userId = "user_id"
	}

	public init(
		phoneNumber: String,
		firstName: String,
		lastName: String?,
		userId: Int?) {
		self.phoneNumber = phoneNumber
		self.firstName = firstName
		self.lastName = lastName
		self.userId = userId
	}

}

public struct Location: Codable {

	public let latitude: Double
	public let longitude: Double

	public init(
		latitude: Double,
		longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}

}

public struct Venue: Codable {

	public let location: Location
	public let title: String
	public let address: String

	/* OPTIONAL. */
	public let foursquareId: String?

	private enum CodingKeys: String, CodingKey {
		case location, title, address
		case foursquareId = "foursquare_id"
	}

	public init(
		location: Location,
		title: String,
		address: String,
		foursquareId: String?) {
		self.location = location
		self.title = title
		self.address = address
		self.foursquareId = foursquareId
	}

}

public struct File: Codable {

	public let fileId: String

	/* OPTIONAL. */
	public let fileSize: Int?
	public let filePath: String?

	private enum CodingKeys: String, CodingKey {
		case fileSize = "file_size"
		case fileId = "file_id"
		case filePath = "file_path"
	}

}

public enum ParseMode: String, Codable {
	case markdown
	case html
}

public enum ChatAction: String, Codable {
	case typing
	case uploadPhoto = "upload_photo"
	case recordVideo = "record_video"
	case uploadVideo = "upload_video"
	case recordAudio = "record_audio"
	case uploadAudio = "upload_audio"
	case uploadDocument = "upload_document"
	case findLocation = "find_location"
}

public struct ChatMember: Codable {

	public let user: User

}

/// https://core.telegram.org/bots/api#inlinekeyboardbutton
public struct InlineKeyboardButton: Codable {

	public let text: String
	public let url: String?
	public let callbackData: String?
	public let switchInlineQuery: String?
	public let switchInlineQueryCurrentChat: String?

	private enum CodingKeys: String, CodingKey {
		case text, url
		case callbackData = "callback_data"
		case switchInlineQuery = "switch_inline_query"
		case switchInlineQueryCurrentChat = "switch_inline_query_current_chat"
	}

	public init(
		text: String,
		url: String? = nil,
		callbackData: String? = nil,
		switchInlineQuery: String? = nil,
		switchInlineQueryCurrentChat: String? = nil) {
		self.text = text
		self.url = url
		self.callbackData = callbackData
		self.switchInlineQuery = switchInlineQuery
		self.switchInlineQueryCurrentChat = switchInlineQueryCurrentChat
	}

}

/// https://core.telegram.org/bots/api#inlinekeyboardmarkup
public struct InlineKeyboardMarkup: Codable {

	public let inlineKeyboard: [[InlineKeyboardButton]]

	private enum CodingKeys: String, CodingKey {
		case inlineKeyboard = "inline_keyboard"
	}

	public init(inlineKeyboard: [[InlineKeyboardButton]]) {
		self.inlineKeyboard = inlineKeyboard
	}

}

/// https://core.telegram.org/bots/api#callbackquery
public struct CallbackQuery: Decodable {

	public let id: String
	public let from: User
	public let message: Message?
	public let inlineMessageId: String?
	public let chatInstance: String?
	public let data: String?

	private enum CodingKeys: String, CodingKey {
		case id, from, message, data
		case inlineMessageId = "inline_message_id"
		case chatInstance = "chat_instance"
	}

}
