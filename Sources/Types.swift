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
	
	var update_id: Int
	
	/* Optional. */
	var message: Message?
	var edited_message: Message?
	//	var inline_query: InlineQuery?
	//	var chosen_inline_result: ChosenInlineResult?
	//	var callback_query: CallbackQuery?
	
	init(update_id: Int,
	     message: Message?,
	     edited_message: Message?
		//		 inline_query: InlineQuery?,
		//		 chosen_inline_result: ChosenInlineResult?,
		//		 callback_query: CallbackQuery?
		) {
		
		self.update_id = update_id
		self.edited_message = edited_message
		self.message = message
		//		self.inline_query = inline_query
		//		self.chosen_inline_result = chosen_inline_result
		//		self.callback_query = callback_query
		
	}
	
}


public class Message {
	
	var message_id: Int
	var date: Int
	var chat: Chat
	
	/* Optional. */
	var from: User?
	var forward_from: User?
	var forward_from_chat: Chat?
	var forward_date: Int?
	var reply_to_message: Message?
	var edit_date: Int?
	var text: String?
	var entities: [MessageEntity]?
	var audio: Audio?
	var document: Document?
	var photo: [PhotoSize]?
	var sticker: Sticker?
	var video: Video?
	var voice: Voice?
	var caption: String?
	var contact: Contact?
	var location: Location?
	var venue: Venue?
	var new_chat_member: User?
	var left_chat_member: User?
	var new_chat_title: String?
	var new_chat_photo: [PhotoSize]?
	var delete_chat_photo: Bool?
	var group_chat_created: Bool?
	var supergroup_chat_created: Bool?
	var channel_chat_created: Bool?
	var migrate_to_chat_id: Int?
	var migrate_from_chat_id: Int?
	var pinned_message: Message?
	
	
	init(message_id: Int,
	     date: Int,
	     chat: Chat,
	     from: User?,
	     forward_from: User?,
	     forward_from_chat: Chat?,
	     forward_date: Int?,
	     reply_to_message: Message?,
	     edit_date: Int?,
	     text: String?,
	     entities: [MessageEntity]?,
	     audio: Audio?,
	     document: Document?,
	     photo: [PhotoSize]?,
	     sticker: Sticker?,
	     video: Video?,
	     voice: Voice?,
	     caption: String?,
	     contact: Contact?,
	     location: Location?,
	     venue: Venue?,
	     new_chat_member: User?,
	     left_chat_member: User?,
	     new_chat_title: String?,
	     new_chat_photo: [PhotoSize]?,
	     delete_chat_photo: Bool?,
	     group_chat_created: Bool?,
	     supergroup_chat_created: Bool?,
	     channel_chat_created: Bool?,
	     migrate_to_chat_id: Int?,
	     migrate_from_chat_id: Int?,
	     pinned_message: Message?
		) {
		
		self.message_id = message_id
		self.date = date
		self.chat = chat
		self.from = from
		self.forward_from = forward_from
		self.forward_from_chat = forward_from_chat
		self.forward_date = forward_date
		self.reply_to_message = reply_to_message
		self.edit_date = edit_date
		self.text = text
		self.entities = entities
		self.audio = audio
		self.document = document
		self.photo = photo
		self.sticker = sticker
		self.video = video
		self.voice = voice
		self.caption = caption
		self.contact = contact
		self.location = location
		self.venue = venue
		self.new_chat_member = new_chat_member
		self.left_chat_member = left_chat_member
		self.new_chat_title = new_chat_title
		self.new_chat_photo = new_chat_photo
		self.delete_chat_photo = delete_chat_photo
		self.group_chat_created = group_chat_created
		self.supergroup_chat_created = supergroup_chat_created
		self.channel_chat_created = channel_chat_created
		self.migrate_to_chat_id = migrate_to_chat_id
		self.migrate_from_chat_id = migrate_from_chat_id
		self.pinned_message = pinned_message
		
	}
	
	/* Conform to Receivable. */
	lazy public var recipientIdentification: [String : String] = {
		
		var recipientIdentification = [String : String]()
		recipientIdentification["chat_id"] = "\(self.chat.id)"
		recipientIdentification["reply_to_message_id"] = "\(self.message_id)"
		return recipientIdentification
		
	} ()
	
	/* Confrom to Forwardable. */
	lazy public var forwardIdentification: [String : String] = {
		
		var forwardIdentification = [String : String]()
		forwardIdentification["message_id"] = "\(self.message_id)"
		forwardIdentification["from_chat_id"] = "\(self.chat.id)"
		return forwardIdentification
		
	} ()
	
}


public struct Chat {
	
	var id: Int
	var type: String
	
	/* Optional. */
	var title: String?
	var username: String?
	var first_name: String?
	var last_name: String?
	
	init(id: Int,
	     type: String,
	     title: String?,
	     username: String?,
	     first_name: String?,
	     last_name: String?) {
		
		self.id = id
		self.type = type
		self.title = title
		self.username = username
		self.first_name = first_name
		self.last_name = last_name
		
	}
	
	/* Conform to Receivable. */
	lazy public var recipientIdentification: [String : String] = {
		
		var recipientIdentification = [String : String]()
		recipientIdentification["chat_id"] = "\(self.id)"
		return recipientIdentification
		
	} ()
	
}


public struct User {
	
	var id: Int
	var first_name: String
	
	/* OPTIONAL. */
	var last_name: String?
	var username: String?
	
	init(id: Int,
	     first_name: String,
	     last_name: String?,
	     username: String?
		) {
		
		self.id = id
		self.first_name = first_name
		self.last_name = last_name
		self.username = username
		
	}
	
}


public struct MessageEntity {
	
	var type: String
	var offset: Int
	var length: Int
	
	/* OPTIONAl. */
	var url: String?
	
	init(type: String,
	     offset: Int,
	     length: Int,
	     url: String?
		){
		
		self.type = type
		self.offset = offset
		self.length = length
		self.url = url
		
	}
	
}


public struct Audio {
	
	var file_id: String
	var duration: Int
	
	/* OPTIONAL. */
	var performer: String?
	var title: String?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     duration: Int,
	     performer: String?,
	     title: String?,
	     mime_type: String?,
	     file_size: Int?
		) {
		
		self.file_id = file_id
		self.duration = duration
		self.performer = performer
		self.title = title
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
}


public struct Document {
	
	var file_id: String
	
	/* OPTIONAL. */
	var thumb: PhotoSize?
	var file_name: String?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     thumb: PhotoSize?,
	     file_name: String?,
	     mime_type: String?,
	     file_size: Int?
		) {
		
		self.file_id = file_id
		self.thumb = thumb
		self.file_name = file_name
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
}


public struct PhotoSize {
	
	var file_id: String
	var width: Int
	var height: Int
	
	/* Optional. */
	var file_size: Int?
	
	init(file_id: String,
	     width: Int,
	     height: Int,
	     file_size: Int?){
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.file_size = file_size
		
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendPhoto"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["photo"] = self.file_id
		return content
	}
	
}


public struct Sticker {
	
	var file_id: String
	var width: Int
	var height: Int
	
	/* Optional. */
	var thumb: PhotoSize?
	var emoji: String?
	var file_size: Int?
	
	init(file_id: String,
	     width: Int,
	     height: Int,
	     thumb: PhotoSize?,
	     emoji: String?,
	     file_size: Int?
		) {
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.thumb = thumb
		self.emoji = emoji
		self.file_size = file_size
		
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendSticker"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["sticker"] = self.file_id
		return content
	}
	
}


public struct Video {
	
	var file_id: String
	var width: Int
	var height: Int
	var duration: Int
	
	/* OPTIONAL. */
	var thumb: PhotoSize?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     width: Int,
	     height: Int,
	     duration: Int,
	     thumb: PhotoSize?,
	     mime_type: String?,
	     file_size: Int?
		){
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = thumb
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
}


public struct Voice {
	
	var file_id: String
	var duration: Int
	
	/* Optional. */
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     duration: Int,
	     mime_type: String?,
	     file_size: Int?
		) {
		
		self.file_id = file_id
		self.duration = duration
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendVoice"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["voice"] = self.file_id
		return content
	}
	
}


public struct Contact {
	
	var phone_number: String
	var first_name: String
	
	/* OPTIONAL. */
	var last_name: String?
	var user_id: Int?
	
	init(phone_number: String,
	     first_name: String,
	     last_name: String?,
	     user_id: Int?
		) {
		
		self.phone_number = phone_number
		self.first_name = first_name
		self.last_name = last_name
		self.user_id = user_id
		
	}
	
}


public struct Location {
	
	var longitude: Double
	var latitude: Double
	
	init(longitude: Double,
	     latitude: Double
		) {
		
		self.longitude = longitude
		self.latitude = latitude
		
	}
}


public struct Venue {
	
	var location: Location
	var title: String
	var address: String
	
	/* OPTIONAL. */
	var foursquare_id: String?
	
	init(location: Location,
	     title: String,
	     address: String,
	     foursquare_id: String?
		) {
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = foursquare_id
		
	}
	
}

