//
//  Types.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

public struct Update {

	public var updateId: Int

	/* Optional. */
	public var message: Message?
	public var editedMessage: Message?
    public var channel_post: Message?
	//	public var inlineQuery: InlineQuery?
	//	public var chosenInlineResult: ChosenInlineResult?
	//	public var callbackQuery: CallbackQuery?

}

public class Message {

	public var messageId: Int
	public var date: Int
	public var chat: Chat

	/* Optional. */
	public var from: User?
	public var forwardFrom: User?
	public var forwardFromChat: Chat?
	public var forwardDate: Int?
	public var replyToMessage: Message?
	public var editDate: Int?
	public var text: String?
	public var entities: [MessageEntity]?
	public var audio: Audio?
	public var document: Document?
	public var photo: [PhotoSize]?
	public var sticker: Sticker?
	public var video: Video?
	public var voice: Voice?
	public var caption: String?
	public var contact: Contact?
	public var location: Location?
	public var venue: Venue?
	public var newChatMember: User?
	public var leftChatMember: User?
	public var newChatTitle: String?
	public var newChatPhoto: [PhotoSize]?
	public var deleteChatPhoto: Bool?
	public var groupChatCreated: Bool?
	public var supergroupChatCreated: Bool?
	public var channelChatCreated: Bool?
	public var migrateToChatId: Int?
	public var migrateFromChatId: Int?
	public var pinnedMessage: Message?

	public init() {
		self.messageId = 0
		self.date = 0
		self.chat = Chat(id: 9, type: .private, title: nil, username: nil, firstName: nil, lastName: nil)
	}

}

public struct Chat {

	public var id: Int
	public var type: StructType

	/* Optional. */
	public var title: String?
	public var username: String?
	public var firstName: String?
	public var lastName: String?

	public enum StructType: String {

		public init?(from string: String?) {
			guard let typeString = string else { return nil }
			guard let instance = StructType(rawValue: typeString.lowercased()) else { return nil }
			self = instance
		}

		case `private`, group, supergroup, channel
	}

}

public struct User {

	public var id: Int
	public var firstName: String

	/* OPTIONAL. */
	public var lastName: String?
	public var username: String?

}

public struct MessageEntity {

	public var type: StructType
	public var offset: Int
	public var length: Int

	/* OPTIONAl. */
	public var url: String?
	public var user: User?

	public enum StructType: String {
		public init?(from string: String?) {
			guard let typeString = string else { return nil }
			guard let instance = StructType(rawValue: typeString.lowercased()) else { return nil }
			self = instance
		}

		case mention, hashtag
		case botCommand = "bot_command"
		case url, email, bold, italic, code, pre
		case textLink = "text_link"
		case textMention = "text_mention"

	}

}

public struct Audio {

	public var fileId: String
	public var duration: Int

	/* OPTIONAL. */
	public var performer: String?
	public var title: String?
	public var mimeType: String?
	public var fileSize: Int?

}

public struct Document {

	public var fileId: String

	/* OPTIONAL. */
	public var thumb: PhotoSize?
	public var fileName: String?
	public var mimeType: String?
	public var fileSize: Int?

}

public struct PhotoSize {

	public var fileId: String
	public var width: Int
	public var height: Int

	/* Optional. */
	public var fileSize: Int?

}

public struct Sticker {

	public var fileId: String
	public var width: Int
	public var height: Int

	/* Optional. */
	public var thumb: PhotoSize?
	public var emoji: String?
	public var fileSize: Int?

}

public struct Video {

	public var fileId: String
	public var width: Int
	public var height: Int
	public var duration: Int

	/* OPTIONAL. */
	public var thumb: PhotoSize?
	public var mimeType: String?
	public var fileSize: Int?

}

public struct Voice {

	public var fileId: String
	public var duration: Int

	/* Optional. */
	public var mimeType: String?
	public var fileSize: Int?

}

public struct Contact {

	public var phoneNumber: String
	public var firstName: String

	/* OPTIONAL. */
	public var lastName: String?
	public var userId: Int?

}

public struct Location {

	public var longitude: Double
	public var latitude: Double

}

public struct Venue {

	public var location: Location
	public var title: String
	public var address: String

	/* OPTIONAL. */
	public var foursquareId: String?

}

public struct File {

	public var fileId: String

	/* OPTIONAL. */
	public var fileSize: Int?
	public var filePath: String?

}

public enum ParseMode: String {
	case markdown
	case html
}

public enum ChatAction: String {
	case typing
	case uploadPhoto = "upload_photo"
	case recordVideo = "record_video"
	case uploadVideo = "upload_video"
	case recordAudio = "record_audio"
	case uploadAudio = "upload_audio"
	case uploadDocument = "upload_document"
	case findLocation = "find_location"
}
