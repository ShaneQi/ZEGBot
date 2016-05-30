//
//  Message.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/10/16.
//  Copyright © 2016 Shane. All rights reserved.
//

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