//
//  Types.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

public struct Update: Codable {

	public let updateId: Int

	/* Optional. */
	public let message: Message?
	public let editedMessage: Message?
	public let channelPost: Message?

	enum CodingKeys: String, CodingKey {
		case message
		case updateId = "update_id"
		case editedMessage = "edited_message"
		case channelPost = "channel_post"
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

	enum CodingKeys: String, CodingKey {
		case date, chat, from, text, entities, audio, document, photo, sticker, video, voice, caption, contact, location, venue
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

	enum CodingKeys: String, CodingKey {
		case id, type, title, username
		case firstName = "first_name"
		case lastName = "last_name"
	}

}

public struct User: Codable {

	public let id: Int
	public let firstName: String

	/* OPTIONAL. */
	public let lastName: String?
	public let username: String?

	enum CodingKeys: String, CodingKey {
		case id, username
		case firstName = "first_name"
		case lastName = "last_name"
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
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

	enum CodingKeys: String, CodingKey {
		case phoneNumber = "phone_number"
		case firstName = "first_name"
		case lastName = "last_name"
		case userId = "user_id"
	}

}

public struct Location: Codable {

	public let longitude: Double
	public let latitude: Double

}

public struct Venue: Codable {

	public let location: Location
	public let title: String
	public let address: String

	/* OPTIONAL. */
	public let foursquareId: String?

	enum CodingKeys: String, CodingKey {
		case location, title, address
		case foursquareId = "foursquare_id"
	}

}

public struct File: Codable {

	public let fileId: String

	/* OPTIONAL. */
	public let fileSize: Int?
	public let filePath: String?

	enum CodingKeys: String, CodingKey {
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
