//
//  Converting.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import SwiftyJSON

protocol JSONConvertible {
	
	init?(from json: JSON)
	
}

protocol ArrayConvertible {
	
	static func array(from json: JSON) -> [Self]?
	
}

extension ArrayConvertible where Self: JSONConvertible {

	internal static func array(from json: JSON) -> [Self]? {
		
		guard !json.isEmpty else { return nil }
		
		guard let jsonArray = json.array else {
				Log.warning(on: json)
				return nil
		}
		
		return jsonArray.map({ Self(from: $0) }).flatMap({ $0 })
		
	}
	
}

extension Update: JSONConvertible, ArrayConvertible {
	
	internal init?(from json: JSON) {
		guard let updateId = json[PARAM.UPDATE_ID].int else {
				Log.warning(on: json)
				return nil
		}
		self.update_id = updateId
		self.message = Message(from: json[PARAM.MESSAGE])
		self.edited_message = Message(from: json[PARAM.EDITED_MESSAGE])
		
	}
	
}

extension Message {
	
	internal convenience init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		self.init()
		
		guard let messageId = json[PARAM.MESSAGE_ID].int,
			let date = json[PARAM.DATE].int,
			let chat = Chat(from: json[PARAM.CHAT]) else {
				Log.warning(on: json)
				return nil
		}
		
		self.message_id = messageId
		self.date = date
		self.chat = chat
		self.from = User(from: json[PARAM.FROM])
		self.forward_from = User(from: json[PARAM.FORWARD_FROM])
		self.forward_from_chat = Chat(from: json[PARAM.FORWARD_FROM_CHAT])
		self.forward_date = json[PARAM.FORWARD_DATE].int
		self.reply_to_message = Message(from: json[PARAM.REPLY_TO_MESSAGE])
		self.edit_date = json[PARAM.EDIT_DATE].int
		self.text = json[PARAM.TEXT].string
		self.entities = MessageEntity.array(from: json[PARAM.ENTITIES])
		self.audio = Audio(from: json[PARAM.AUDIO])
		self.document = Document(from: json[PARAM.DOCUMENT])
		self.photo = PhotoSize.array(from: json[PARAM.PHOTO])
		self.sticker = Sticker(from: json[PARAM.STICKER])
		self.video = Video(from: json[PARAM.VIDEO])
		self.voice = Voice(from: json[PARAM.VOICE])
		self.caption = json[PARAM.CAPTION].string
		self.contact = Contact(from: json[PARAM.CONTACT])
		self.location = Location(from: json[PARAM.LOCATION])
		self.venue = Venue(from: json[PARAM.VENUE])
		self.new_chat_member = User(from: json[PARAM.NEW_CHAT_MEMBER])
		self.left_chat_member = User(from: json[PARAM.LEFT_CHAT_MEMBER])
		self.new_chat_title = json[PARAM.NEW_CHAT_TITLE].string
		self.new_chat_photo = PhotoSize.array(from: json[PARAM.NEW_CHAT_PHOTO])
		self.delete_chat_photo = json[PARAM.DELETE_CHAT_PHOTO].bool
		self.group_chat_created = json[PARAM.GROUP_CHAT_CREATED].bool
		self.supergroup_chat_created = json[PARAM.SUPER_GROUP_CHAT_CREATED].bool
		self.channel_chat_created = json[PARAM.CHANNEL_CHAT_CREATED].bool
		self.migrate_to_chat_id = json[PARAM.MIGRATE_TO_CHAT_ID].int
		self.migrate_from_chat_id = json[PARAM.MIGRATE_FROM_CHAT_ID].int
		self.pinned_message = Message(from: json[PARAM.PINNED_MESSAGE])
		
	}
	
}

extension Chat: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let id = json[PARAM.ID].int,
			let type = Chat.StructType(from: json[PARAM.TYPE].string) else {
				Log.warning(on: json)
				return nil
		}
		
		self.id = id
		self.type = type
		self.title = json[PARAM.TITLE].string
		self.username = json[PARAM.USERNAME].string
		self.first_name = json[PARAM.FIRST_NAME].string
		self.last_name = json[PARAM.LAST_NAME].string
		
	}
	
}

extension User: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let id = json[PARAM.ID].int,
			let firstName = json[PARAM.FIRST_NAME].string else {
				Log.warning(on: json)
				return nil
		}
		
		self.id = id
		self.first_name = firstName
		self.last_name = json[PARAM.LAST_NAME].string
		self.username = json[PARAM.USERNAME].string
		
	}
	
}

extension MessageEntity: JSONConvertible, ArrayConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let type = MessageEntity.StructType(from: json[PARAM.TYPE].string),
			let offset = json[PARAM.OFFSET].int,
			let length = json[PARAM.LENGTH].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.type = type
		self.offset = offset
		self.length = length
		self.url = json[PARAM.URL].string
		self.user = User(from: json[PARAM.USER])
	}
	
}

extension Audio: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string,
			let duration = json[PARAM.DURATION].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.duration = duration
		self.performer = json[PARAM.PERFORMER].string
		self.title = json[PARAM.TITLE].string
		self.mime_type = json[PARAM.MIME_SIZE].string
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension Document: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.thumb = PhotoSize(from: json[PARAM.THUMB])
		self.file_name = json[PARAM.FILE_NAME].string
		self.mime_type = json[PARAM.MIME_TYPE].string
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension PhotoSize: JSONConvertible, ArrayConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string,
			let width = json[PARAM.WIDTH].int,
			let height = json[PARAM.HEIGHT].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension Sticker: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string,
			let width = json[PARAM.WIDTH].int,
			let height = json[PARAM.HEIGHT].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.thumb = PhotoSize(from: json[PARAM.THUMB])
		self.emoji = json[PARAM.EMOJI].string
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension Video: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string,
			let width = json[PARAM.WIDTH].int,
			let height = json[PARAM.HEIGHT].int,
			let duration = json[PARAM.DURATION].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = PhotoSize(from: json[PARAM.THUMB])
		self.mime_type = json[PARAM.MIME_TYPE].string
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension Voice: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let fileId = json[PARAM.FILE_ID].string,
			let duration = json[PARAM.DURATION].int else {
				Log.warning(on: json)
				return nil
		}
		
		self.file_id = fileId
		self.duration = duration
		self.mime_type = json[PARAM.MIME_TYPE].string
		self.file_size = json[PARAM.FILE_SIZE].int
		
	}
	
}

extension Contact: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let phoneNumber = json[PARAM.PHONE_NUMBER].string,
			let firstName = json[PARAM.FIRST_NAME].string else {
				Log.warning(on: json)
				return nil
		}
		
		self.phone_number = phoneNumber
		self.first_name = firstName
		self.last_name = json[PARAM.LAST_NAME].string
		self.user_id = json[PARAM.USER_ID].int
		
	}
	
}

extension Location: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let longitude = json[PARAM.LONGITUDE].double,
			let latitude = json[PARAM.LATITUDE].double else {
				Log.warning(on: json)
				return nil
		}
		
		self.longitude = longitude
		self.latitude = latitude
		
	}
	
}

extension Venue: JSONConvertible {
	
	internal init?(from json: JSON) {
		
		guard !json.isEmpty else { return nil }
		
		guard let location = Location(from: json[PARAM.LOCATION]),
			let title = json[PARAM.TITLE].string,
			let address = json[PARAM.ADDRESS].string else {
				Log.warning(on: json)
				return nil
		}
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = json[PARAM.FOURSQUARE_ID].string
		
	}
	
}

extension File: JSONConvertible {

	internal init?(from json: JSON) {
		guard !json.isEmpty else { return nil }

		guard let fileId = json[PARAM.FILE_ID].string,
			let fileSize = json[PARAM.FILE_SIZE].int,
			let filePath = json[PARAM.FILE_PATH].string else {
				Log.warning(on: json)
				return nil
		}

		self.fileId = fileId
		self.fileSize = fileSize
		self.filePath = filePath
	}

}
