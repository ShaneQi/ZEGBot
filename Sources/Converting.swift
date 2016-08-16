//
//  Converting.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

protocol JSONConvertible {
	
	init?(from jsonConvertibleObject: Any?)
	
}

protocol ArrayConvertible {
	
	static func array(from jsonConvertibleObject: Any?) -> [Self]?
	
}

extension Update: JSONConvertible {
	
    internal struct PARAM {
        static let UPDATE_ID = "update_id"
        static let MESSAGE = "message"
        static let EDITED_MESSAGE = "edited_message"
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
		self.message = Message(from: jsonDictionary[PARAM.MESSAGE])
		self.edited_message = Message(from: jsonDictionary[PARAM.EDITED_MESSAGE])
		
	}
	
}

extension Message {

    internal struct PARAM {
        static let MESSAGE_ID =             "message_id"
        static let DATE =                   "date"
        static let CHAT =                   "chat"
        static let FROM =                   "from"
        static let FORWARD_FROM =           "forward_from"
        static let FORWARD_FROM_CHAT =      "forward_from_chat"
        static let FORWARD_DATE =           "forward_date"
        static let REPLY_TO_MESSAGE =       "reply_to_message"
        static let EDIT_DATE =              "edit_date"
        static let TEXT =                   "text"
        static let ENTITIES =               "entities"
        static let AUDIO =                  "audio"
        static let DOCUMENT =               "document"
        static let PHOTO =                  "photo"
        static let STICKER =                "sticker"
        static let VIDEO =                  "video"
        static let VOICE =                  "voice"
        static let CAPTION =                "caption"
        static let CONTACT =                "contact"
        static let LOCATION =               "location"
        static let VENUE =                  "venue"
        static let NEW_CHAT_MEMBER =        "new_chat_member"
        static let LEFT_CHAT_MEMBER =       "left_chat_member"
        static let NEW_CHAT_TITLE =         "new_chat_title"
        static let NEW_CHAT_PHOTO =         "new_chat_photo"
        static let DELETE_CHAT_PHOTO =      "delete_chat_photo"
        static let GROUP_CHAT_CREATED =     "group_chat_created"
        static let SUPER_GROUP_CHAT_CREATED="super_group_chat_created"
        static let CHANNEL_CHAT_CREATED =   "channel_chat_created"
        static let MIGRATE_TO_CHAT_ID =     "migrate_to_chat_id"
        static let MIGRATE_FROM_CHAT_ID =   "migrate_from_chat_id"
        static let PINNED_MESSAGE =         "pinned_message"
    }
    
	internal convenience init?(from jsonConvertibleObject: Any?) {
        
        self.init()
        
		guard jsonConvertibleObject != nil else { return nil }

		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let messageId = jsonDictionary[PARAM.MESSAGE_ID] as? Int,
			let date = jsonDictionary[PARAM.DATE] as? Int,
			let chat = Chat(from: jsonDictionary[PARAM.CHAT])
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
        self.message_id = messageId
        self.date = date
        self.chat = chat
        self.from = User(from: jsonDictionary[PARAM.FROM])
		self.forward_from = User(from: jsonDictionary[PARAM.FORWARD_FROM])
		self.forward_from_chat = Chat(from: jsonDictionary[PARAM.FORWARD_FROM_CHAT])
		self.forward_date = jsonDictionary[PARAM.FORWARD_DATE] as? Int
		self.reply_to_message = Message(from: jsonDictionary[PARAM.REPLY_TO_MESSAGE])
		self.edit_date = jsonDictionary[PARAM.EDIT_DATE] as? Int
		self.text = jsonDictionary[PARAM.TEXT] as? String
		self.entities = MessageEntity.array(from: jsonDictionary[PARAM.ENTITIES])
		self.audio = Audio(from: jsonDictionary[PARAM.AUDIO])
		self.document = Document(from: jsonDictionary[PARAM.DOCUMENT])
		self.photo = PhotoSize.array(from: jsonDictionary[PARAM.PHOTO])
		self.sticker = Sticker(from: jsonDictionary[PARAM.STICKER])
		self.video = Video(from: jsonDictionary[PARAM.VIDEO])
		self.voice = Voice(from: jsonDictionary[PARAM.VOICE])
		self.caption = jsonDictionary[PARAM.CAPTION] as? String
		self.contact = Contact(from: jsonDictionary[PARAM.CONTACT])
		self.location = Location(from: jsonDictionary[PARAM.LOCATION])
		self.venue = Venue(from: jsonDictionary[PARAM.VENUE])
		self.new_chat_member = User(from: jsonDictionary[PARAM.NEW_CHAT_MEMBER])
		self.left_chat_member = User(from: jsonDictionary[PARAM.LEFT_CHAT_MEMBER])
		self.new_chat_title = jsonDictionary[PARAM.NEW_CHAT_TITLE] as? String
		self.new_chat_photo = PhotoSize.array(from: jsonDictionary[PARAM.NEW_CHAT_PHOTO])
		self.delete_chat_photo = jsonDictionary[PARAM.DELETE_CHAT_PHOTO] as? Bool
		self.group_chat_created = jsonDictionary[PARAM.GROUP_CHAT_CREATED] as? Bool
		self.supergroup_chat_created = jsonDictionary[PARAM.SUPER_GROUP_CHAT_CREATED] as? Bool
		self.channel_chat_created = jsonDictionary[PARAM.CHANNEL_CHAT_CREATED] as? Bool
		self.migrate_to_chat_id = jsonDictionary[PARAM.MIGRATE_TO_CHAT_ID] as? Int
		self.migrate_from_chat_id = jsonDictionary[PARAM.MIGRATE_FROM_CHAT_ID] as? Int
		self.pinned_message = Message(from: jsonDictionary[PARAM.PINNED_MESSAGE])

		}

}

extension Chat: JSONConvertible {
	
    internal struct PARAM {
        static let ID =                     "id"
        static let TYPE =                   "type"
        static let TITLE =                  "title"
        static let USERNAME =               "username"
        static let FIRST_NAME =             "first_name"
        static let LAST_NAME =              "last_name"
    }
    
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary[PARAM.ID] as? Int,
			let type = Chat.sType(from: jsonDictionary[PARAM.TYPE] as? String)
			else {
		
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.id = id
		self.type = type
		self.title = jsonDictionary[PARAM.TITLE] as? String
		self.username = jsonDictionary[PARAM.USERNAME] as? String
        self.first_name = jsonDictionary[PARAM.FIRST_NAME] as? String
        self.last_name = jsonDictionary[PARAM.LAST_NAME] as? String
		
	}
	
}

extension User: JSONConvertible {
    
    internal struct PARAM {
        static let ID =             "id"
        static let FIRST_NAME =     "first_name"
        static let LAST_NAME =      "last_name"
        static let USERNAME =       "username"
    }
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let id = jsonDictionary[PARAM.ID] as? Int,
			let firstName = jsonDictionary[PARAM.FIRST_NAME] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
		
		}

		self.id = id
		self.first_name = firstName
		self.last_name = jsonDictionary[PARAM.LAST_NAME] as? String
		self.username = jsonDictionary[PARAM.USERNAME] as? String
		
	}
	
}

extension MessageEntity: JSONConvertible, ArrayConvertible {

    internal struct PARAM {
        static let TYPE =               "type"
        static let OFFSET =             "offset"
        static let LENGTH =             "length"
        static let URL =                "url"
        static let USER =               "user"
    }
    
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let type = MessageEntity.sType(from: jsonDictionary[PARAM.TYPE] as? String),
			let offset = jsonDictionary[PARAM.OFFSET] as? Int,
			let length = jsonDictionary[PARAM.LENGTH] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
        
		self.type = type
		self.offset = offset
		self.length = length
		self.url = jsonDictionary[PARAM.URL] as? String
		self.user = User(from: jsonDictionary[PARAM.USER])
	}
	
	internal static func array(from jsonConvertibleObject: Any?) -> [MessageEntity]? {
		
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
    
    internal struct PARAM {
        static let FILE_ID =                "file_id"
        static let DURATION =               "duration"
        static let PERFORMER =              "performer"
        static let TITLE =                  "title"
        static let MIME_SIZE =              "mime_size"
        static let FILE_SIZE =              "file_size"
    }

	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
			
			Log.warning(on: jsonConvertibleObject)
			return nil
			
		}
        
		self.file_id = fileId
		self.duration = duration
		self.performer = jsonDictionary[PARAM.PERFORMER] as? String
		self.title = jsonDictionary[PARAM.TITLE] as? String
		self.mime_type = jsonDictionary[PARAM.MIME_SIZE] as? String
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int

	}
	
}

extension Document: JSONConvertible {

    internal struct PARAM {
        static let FILE_ID =            "file_id"
        static let THUMB =              "thumb"
        static let FILE_NAME =          "file_name"
        static let MIME_TYPE =          "mime_type"
        static let FILE_SIZE =          "file_size"
    }
    
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.file_id = fileId
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.file_name = jsonDictionary[PARAM.FILE_NAME] as? String
		self.mime_type = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension PhotoSize: JSONConvertible, ArrayConvertible {
	
	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let FILE_SIZE =			"file_size"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}

		self.file_id = fileId
		self.width = width
		self.height = height
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
	internal static func array(from jsonConvertibleObject: Any?) -> [PhotoSize]? {
		
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

	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let THUMB =				"thumb"
		static let EMOJI =				"emoji"
		static let FILE_SIZE =			"file_size"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}

		self.file_id = fileId
		self.width = width
		self.height = height
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.emoji = jsonDictionary[PARAM.EMOJI] as? String
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int

	}

}

extension Video: JSONConvertible {
	
	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let DURATION =			"duration"
		static let THUMB =				"thumb"
		static let MIME_TYPE =			"mime_type"
		static let FILE_SIZE =			"file_size"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let width = jsonDictionary[PARAM.WIDTH] as? Int,
			let height = jsonDictionary[PARAM.HEIGHT] as? Int,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}

		self.file_id = fileId
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = PhotoSize(from: jsonDictionary[PARAM.THUMB])
		self.mime_type = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int

	}

}

extension Voice: JSONConvertible {

	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let DURATION =			"duration"
		static let MIME_TYPE =			"mime_type"
		static let FILE_SIZE =			"file_size"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let fileId = jsonDictionary[PARAM.FILE_ID] as? String,
			let duration = jsonDictionary[PARAM.DURATION] as? Int
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.file_id = fileId
		self.duration = duration
		self.mime_type = jsonDictionary[PARAM.MIME_TYPE] as? String
		self.file_size = jsonDictionary[PARAM.FILE_SIZE] as? Int
		
	}
	
}

extension Contact: JSONConvertible {

	internal struct PARAM {
		static let PHONE_NUMBER =			"phone_number"
		static let FIRST_NAME =				"first_name"
		static let LAST_NAME =				"last_name"
		static let USER_ID =				"user_id"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let phoneNumber = jsonDictionary[PARAM.PHONE_NUMBER] as? String,
			let firstName = jsonDictionary[PARAM.FIRST_NAME] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.phone_number = phoneNumber
		self.first_name = firstName
		self.last_name = jsonDictionary[PARAM.LAST_NAME] as? String
		self.user_id = jsonDictionary[PARAM.USER_ID] as? Int
		
	}

}

extension Location: JSONConvertible {
	
	internal struct PARAM {
		static let LONGITUDE =			"longitude"
		static let LATITUDE =			"latitude"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let longitude = jsonDictionary[PARAM.LONGITUDE] as? Double,
			let latitude = jsonDictionary[PARAM.LATITUDE] as? Double
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}
		
		self.longitude = longitude
		self.latitude = latitude
		
	}

}

extension Venue: JSONConvertible {
	
	internal struct PARAM {
		static let LOCATION =				"location"
		static let TITLE =					"title"
		static let ADDRESS =				"address"
		static let FOURSQUARE_ID =			"foursquare_id"
	}
	
	internal init?(from jsonConvertibleObject: Any?) {
		
		guard jsonConvertibleObject != nil else { return nil }
		
		guard let
			jsonDictionary = jsonConvertibleObject as? [String: Any],
			let location = Location(from: jsonDictionary[PARAM.LOCATION]),
			let title = jsonDictionary[PARAM.TITLE] as? String,
			let address = jsonDictionary[PARAM.ADDRESS] as? String
			else {
				
				Log.warning(on: jsonConvertibleObject)
				return nil
				
		}

		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = jsonDictionary[PARAM.FOURSQUARE_ID] as? String
		
	}
}
