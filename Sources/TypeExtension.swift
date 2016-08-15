//
//  TypeExtension.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

public enum ParseMode: String {
    case Markdown
    case HTML
}

protocol JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?)
	
}

protocol ArrayConvertible {
	
	static func array(from jsonConvertibleObject: Any?) -> [Self]?
	
}

extension Update: JSONConvertible {
	
    internal struct PARAM {
        static let UPDATE_ID = "update_id"
    }
    
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let updateId = jsonDictionary[PARAM.UPDATE_ID] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
    
		self.update_id = updateId
		self.message = Message(from: jsonDictionary["message"])
		self.edited_message = Message(from: jsonDictionary["edited_message"])
		
	}
	
}

extension Message {

    internal struct PARAM {
        static let MESSAGE_ID = "message_id"
    }
    
	internal convenience init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }

		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let messageId = jsonDictionary[PARAM.MESSAGE_ID] as? Int,
			let date = jsonDictionary["date"] as? Int,
			let chat = Chat(from: jsonDictionary["chat"])
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let from = User(from: jsonDictionary["from"])
		let forwardFrom = User(from: jsonDictionary["forward_from"])
		let forwardFromChat = Chat(from: jsonDictionary["forward_from_chat"])
		let forwardDate = jsonDictionary["forward_date"] as? Int
		let replyToMessage = Message(from: jsonDictionary["reply_to_message"])
		let editDate = jsonDictionary["edit_date"] as? Int
		let text = jsonDictionary["text"] as? String
		let entities = MessageEntity.array(from: jsonDictionary["entities"])
		let audio = Audio(from: jsonDictionary["audio"])
		let document = Document(from: jsonDictionary["document"])
		let photo = PhotoSize.array(from: jsonDictionary["photo"])
		let sticker = Sticker(from: jsonDictionary["sticker"])
		let video = Video(from: jsonDictionary["video"])
		let voice = Voice(from: jsonDictionary["voice"])
		let caption = jsonDictionary["caption"] as? String
		let contact = Contact(from: jsonDictionary["contact"])
		let location = Location(from: jsonDictionary["location"])
		let venue = Venue(from: jsonDictionary["venue"])
		let newChatMember = User(from: jsonDictionary["new_chat_member"])
		let leftChatMember = User(from: jsonDictionary["left_chat_member"])
		let newChatTitle = jsonDictionary["new_chat_title"] as? String
		let newChatPhoto = PhotoSize.array(from: jsonDictionary["new_chat_photo"])
		let deleteChatPhoto = jsonDictionary["delete_chat_photo"] as? Bool
		let groupChatCreated = jsonDictionary["group_chat_created"] as? Bool
		let supergroupChatCreated = jsonDictionary["supergroup_chat_created"] as? Bool
		let channelChatCreated = jsonDictionary["channel_chat_created"] as? Bool
		let migrateToChatId = jsonDictionary["migrate_to_chat_id"] as? Int
		let migrateFromChatId = jsonDictionary["migrate_from_chat_id"] as? Int
		let pinnedMessage = Message(from: jsonDictionary["pinned_message"])

		self.init(message_id: messageId,
					date: date,
					chat: chat,
					from: from,
					forward_from: forwardFrom,
					forward_from_chat: forwardFromChat,
					forward_date: forwardDate,
					reply_to_message: replyToMessage,
					edit_date: editDate,
					text: text,
					entities: entities,
					audio: audio,
					document: document,
					photo: photo,
					sticker: sticker,
					video: video,
					voice: voice,
					caption: caption,
					contact: contact,
					location: location,
					venue: venue,
					new_chat_member: newChatMember,
					left_chat_member: leftChatMember,
					new_chat_title: newChatTitle,
					new_chat_photo: newChatPhoto,
					delete_chat_photo: deleteChatPhoto,
					group_chat_created: groupChatCreated,
					supergroup_chat_created: supergroupChatCreated,
					channel_chat_created: channelChatCreated,
					migrate_to_chat_id: migrateToChatId,
					migrate_from_chat_id: migrateFromChatId,
					pinned_message: pinnedMessage
		)
	}

}

extension Chat: JSONConvertible {
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary["id"] as? Int,
			let type = Chat.sType(from: jsonDictionary["type"] as? String)
			else {
		
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.id = id
		self.type = type
		self.title = jsonDictionary["title"] as? String
		self.username = jsonDictionary["username"] as? String
        self.first_name = jsonDictionary["first_name"] as? String
        self.last_name = jsonDictionary["last_name"] as? String
		
	}
	
}

extension User: JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary["id"] as? Int,
			let firstName = jsonDictionary["first_name"] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
		
		}
		
		let lastName = jsonDictionary["last_name"] as? String
		let username = jsonDictionary["username"] as? String
		
		self.id = id
		self.first_name = firstName
		self.last_name = lastName
		self.username = username
		
	}
	
}

extension MessageEntity: JSONConvertible, ArrayConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let type = jsonDictionary["type"] as? String,
			let offset = jsonDictionary["offset"] as? Int,
			let length = jsonDictionary["length"] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let url = jsonDictionary["url"] as? String
		let user = User(from: jsonDictionary["user"])
		
		self.type = type
		self.offset = offset
		self.length = length
		self.url = url
		self.user = user
	}
	
	static func array(from jsonConvertibleObject: Any?) -> [MessageEntity]? {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonArray = jsonConvertibleObject as? [Any]
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
		
		}
		
		var messageEntities = [MessageEntity]()
		
		for jsonDictionaryObject in jsonArray {
			
			if let messageEntity = MessageEntity(from: jsonDictionaryObject) {
				
				messageEntities.append(messageEntity)
				
			}
			
		}
		
		return messageEntities
	
	}

}

extension Audio: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String,
			let duration = jsonDictionary["duration"] as? Int
			else {
			
			Log.warning(on: jsonConvertibleObject)
			return nil
			
		}
		
		let performer = jsonDictionary["performer"] as? String
		let title = jsonDictionary["title"] as? String
		let mimeType = jsonDictionary["mime_size"] as? String
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.duration = duration
		self.performer = performer
		self.title = title
		self.mime_type = mimeType
		self.file_size = fileSize

	}
	
}

extension Document: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let thumb = PhotoSize(from: jsonDictionary["thumb"])
		let fileName = jsonDictionary["file_name"] as? String
		let mimeType = jsonDictionary["mime_type"] as? String
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.thumb = thumb
		self.file_name = fileName
		self.mime_type = mimeType
		self.file_size = fileSize
		
	}
	
}

extension PhotoSize: JSONConvertible, ArrayConvertible {
	
	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String,
			let width = jsonDictionary["width"] as? Int,
			let height = jsonDictionary["height"] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.file_size = fileSize
		
	}
	
	static func array(from jsonConvertibleObject: Any?) -> [PhotoSize]? {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonArray = jsonConvertibleObject as? [Any]
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		var photoSizes = [PhotoSize]()
		
		for jsonDictionaryObject in jsonArray {
			
			if let photoSize = PhotoSize(from: jsonDictionaryObject) {
				
				photoSizes.append(photoSize)
				
			}
			
		}
		
		return photoSizes
		
	}

}

extension Sticker: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String,
			let width = jsonDictionary["width"] as? Int,
			let height = jsonDictionary["height"] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let thumb = PhotoSize(from: jsonDictionary["thumb"])
		let emoji = jsonDictionary["emoji"] as? String
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.thumb = thumb
		self.emoji = emoji
		self.file_size = fileSize

	}

}

extension Video: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String,
			let width = jsonDictionary["width"] as? Int,
			let height = jsonDictionary["height"] as? Int,
			let duration = jsonDictionary["duration"] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let thumb = PhotoSize(from: jsonDictionary["thumb"])
		let mimeType = jsonDictionary["mime_type"] as? String
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = thumb
		self.mime_type = mimeType
		self.file_size = fileSize

	}

}

extension Voice: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary["file_id"] as? String,
			let duration = jsonDictionary["duration"] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
	
		let mimeType = jsonDictionary["mime_type"] as? String
		let fileSize = jsonDictionary["file_size"] as? Int
		
		self.file_id = fileId
		self.duration = duration
		self.mime_type = mimeType
		self.file_size = fileSize
		
	}
	
}

extension Contact: JSONConvertible {

	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let phoneNumber = jsonDictionary["phone_number"] as? String,
			let firstName = jsonDictionary["first_name"] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let lastName = jsonDictionary["last_name"] as? String
		let userId = jsonDictionary["user_id"] as? Int
		
		self.phone_number = phoneNumber
		self.first_name = firstName
		self.last_name = lastName
		self.user_id = userId
		
	}

}

extension Location: JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let longitude = jsonDictionary["longitude"] as? Double,
			let latitude = jsonDictionary["latitude"] as? Double
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.longitude = longitude
		self.latitude = latitude
		
	}

}

extension Venue: JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let location = Location(from: jsonDictionary["location"]),
			let title = jsonDictionary["title"] as? String,
			let address = jsonDictionary["address"] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		let foursquareId = jsonDictionary["foursquare_id"] as? String
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = foursquareId
		
	}
}
