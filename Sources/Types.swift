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
	
    init() {
        self.message_id = 0
        self.date = 0
        self.chat = Chat(id: 0, type: .PRIVATE)
    }
		
}


public struct Chat {

	var id: Int
	var type: sType
	
	/* Optional. */
	var title: String?
	var username: String?
	var first_name: String?
	var last_name: String?
    
    init(id: Int, type: sType) {
        
        self.id = id
        self.type = type
        
    }
    
    enum sType: String {
        
        init?(from string: String?) {
            guard let typeString = string else { return nil }
            guard let instance = sType(rawValue: typeString.uppercased()) else { return nil }
            self = instance
        }
        
        case PRIVATE, GROUP, SUPERGROUP, CHANNEL
    }

}


public struct User {
	
	var id: Int
	var first_name: String
	
	/* OPTIONAL. */
	var last_name: String?
	var username: String?
	
	init(id: Int,
	     first_name: String,
	     last_name: String? = nil,
	     username: String? = nil
		) {
		
		self.id = id
		self.first_name = first_name
		self.last_name = last_name
		self.username = username
		
	}
	
}


public struct MessageEntity {
	
	var type: sType
	var offset: Int
	var length: Int
	
	/* OPTIONAl. */
	var url: String?
	var user: User?
    
    enum sType: String {
        init?(from string: String?) {
            guard let typeString = string else { return nil }
            guard let instance = sType(rawValue: typeString.uppercased()) else { return nil }
            self = instance
        }
        
        case MENTION, HASHTAG, BOT_COMMAND, URL, EMAIL, BOLD, ITALIC, CODE, PRE, TEXT_LINK, TEXT_MENTION

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
	     performer: String? = nil,
	     title: String? = nil,
	     mime_type: String? = nil,
	     file_size: Int? = nil
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
	     thumb: PhotoSize? = nil,
	     file_name: String? = nil,
	     mime_type: String? = nil,
	     file_size: Int? = nil
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
	     file_size: Int? = nil
		){
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.file_size = file_size
		
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
	     thumb: PhotoSize? = nil,
	     emoji: String? = nil,
	     file_size: Int? = nil
		) {
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.thumb = thumb
		self.emoji = emoji
		self.file_size = file_size
		
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
	     thumb: PhotoSize? = nil,
	     mime_type: String? = nil,
	     file_size: Int? = nil
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
	     mime_type: String? = nil,
	     file_size: Int? = nil
		) {
		
		self.file_id = file_id
		self.duration = duration
		self.mime_type = mime_type
		self.file_size = file_size
		
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
	     last_name: String? = nil,
	     user_id: Int? = nil
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
	     foursquare_id: String? = nil
		) {
		
		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = foursquare_id
		
	}
	
}

public enum ParseMode: String {
	case Markdown
	case HTML
}
