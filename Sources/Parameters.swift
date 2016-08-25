//
//  Parameters.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/25/16.
//
//

extension ZEGBot {

	
	internal struct PARAM {
		
		/* Master param strings. */
		static let DISABLE_NOTIFICATION =			"disable_notification"
		static let POST_JSON_HEADER_CONTENT_TYPE =	"Content-Type: application/json"
		static let RESULT =							"result"
		
		/* Shared param strings. */
		static let CAPTION =						"caption"
		static let MESSAGE_ID =						"message_id"
		static let FROM_CHAT_ID =					"from_chat_id"
		static let LATITUDE =						"latitude"
		static let LONGITUDE =						"longitude"
		
		static let SEND_MESSAGE =					"sendMessage"
		static let TEXT =							"text"
		static let PARSE_MODE =						"parse_mode"
		static let DISABLE_WEB_PAGE_PREVIEW =		"disable_web_page_preview"
		
		static let FORWARD_MESSAGE =				"forwardMessage"
		
		static let SEND_PHOTO =						"sendPhoto"
		static let PHOTO =							"photo"
		
		static let SEND_AUDIO =						"sendAudio"
		static let AUDIO =							"audio"
		
		static let SEND_DOCUMENT =					"sendDocument"
		static let DOCUMENT =						"document"
		
		static let SEND_STICKER =					"sendSticker"
		static let STICKER =						"sticker"
		
		static let SEND_VIDEO =						"sendVideo"
		static let VIDEO =							"video"
		
		static let SEND_VOICE =						"sendVoice"
		static let VOICE =							"voice"
		
		static let SEND_LOCATION =					"sendLocation"

		static let SEND_VENUE =						"sendVenue"
		static let TITLE =							"title"
		static let ADDRESS =						"address"
		static let FOURSQUARE_ID =					"foursquare_id"
		
		static let SEND_CONTACT =					"sendContact"
		static let PHONE_NUMBER =					"phone_number"
		static let FIRST_NAME =						"first_name"
		static let LAST_NAME =						"last_name"
		
		static let SEND_CHAT_ACTION =				"sendChatAction"
		static let ACTION =							"action"
		
	}
	
}

extension Update {
	
	internal struct PARAM {
		static let UPDATE_ID = "update_id"
		static let MESSAGE = "message"
		static let EDITED_MESSAGE = "edited_message"
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
	
}

extension Chat {
	
	internal struct PARAM {
		static let ID =                     "id"
		static let TYPE =                   "type"
		static let TITLE =                  "title"
		static let USERNAME =               "username"
		static let FIRST_NAME =             "first_name"
		static let LAST_NAME =              "last_name"
	}
	
}

extension User {
	
	internal struct PARAM {
		static let ID =             "id"
		static let FIRST_NAME =     "first_name"
		static let LAST_NAME =      "last_name"
		static let USERNAME =       "username"
	}
	
}

extension MessageEntity {
	
	internal struct PARAM {
		static let TYPE =               "type"
		static let OFFSET =             "offset"
		static let LENGTH =             "length"
		static let URL =                "url"
		static let USER =               "user"
	}
	
}

extension Audio {
	
	internal struct PARAM {
		static let FILE_ID =                "file_id"
		static let DURATION =               "duration"
		static let PERFORMER =              "performer"
		static let TITLE =                  "title"
		static let MIME_SIZE =              "mime_size"
		static let FILE_SIZE =              "file_size"
	}

}

extension Document {
	
	internal struct PARAM {
		static let FILE_ID =            "file_id"
		static let THUMB =              "thumb"
		static let FILE_NAME =          "file_name"
		static let MIME_TYPE =          "mime_type"
		static let FILE_SIZE =          "file_size"
	}
	
}

extension PhotoSize {
	
	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let FILE_SIZE =			"file_size"
	}
	
}

extension Sticker {

	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let THUMB =				"thumb"
		static let EMOJI =				"emoji"
		static let FILE_SIZE =			"file_size"
	}
	
}

extension Video {
	
	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let WIDTH =				"width"
		static let HEIGHT =				"height"
		static let DURATION =			"duration"
		static let THUMB =				"thumb"
		static let MIME_TYPE =			"mime_type"
		static let FILE_SIZE =			"file_size"
	}
	
}

extension Voice {
	
	internal struct PARAM {
		static let FILE_ID =			"file_id"
		static let DURATION =			"duration"
		static let MIME_TYPE =			"mime_type"
		static let FILE_SIZE =			"file_size"
	}

}

extension Contact {
	
	internal struct PARAM {
		static let PHONE_NUMBER =			"phone_number"
		static let FIRST_NAME =				"first_name"
		static let LAST_NAME =				"last_name"
		static let USER_ID =				"user_id"
	}

}

extension Location {
	
	internal struct PARAM {
		static let LONGITUDE =			"longitude"
		static let LATITUDE =			"latitude"
	}
	
}

extension Venue {

	internal struct PARAM {
		static let LOCATION =				"location"
		static let TITLE =					"title"
		static let ADDRESS =				"address"
		static let FOURSQUARE_ID =			"foursquare_id"
	}
	
}
