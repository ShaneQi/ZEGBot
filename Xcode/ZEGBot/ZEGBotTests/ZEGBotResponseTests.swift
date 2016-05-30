//
//  ZEGBotResponseTests.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

import XCTest
@testable import ZEGBot

class ZEGBotResponseTests: XCTestCase {
	
	var chat: Chat!
	var message: Message!
	var photo: PhotoSize!
	var audio: Audio!
	var document: Document!
	var sticker: Sticker!
	var video: Video!
	var voice: Voice!
	var location: Location!
	var venue: Venue!
	var contact: Contact!
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		chat = Chat(id: 80548625, type: "", title: nil, username: nil, first_name: nil, last_name: nil)
		message = Message(message_id: 36891, date: 0, chat: chat, from: nil, forward_from: nil, forward_from_chat: nil, forward_date: nil, reply_to_message: nil, edit_date: nil, text: nil, entities: nil, audio: nil, document: nil, photo: nil, sticker: nil, video: nil, voice: nil, caption: nil, contact: nil, location: nil, venue: nil, new_chat_member: nil, left_chat_member: nil, new_chat_title: nil, new_chat_photo: nil, delete_chat_photo: nil, group_chat_created: nil, supergroup_chat_created: nil, channel_chat_created: nil, migrate_to_chat_id: nil, migrate_from_chat_id: nil, pinned_message: nil)
		photo = PhotoSize(file_id: "AgADAwADtacxG8AQvwQNpE8e0bCRkKz0hjEABG7zoyhICRg75pEAAgI", width: 0, height: 0, file_size: nil)
		audio = Audio(file_id: "BQADBQADzwADuy23BKu8f1YGCTP2Ag", duration: 0, performer: nil, title: nil, mime_type: nil, file_size: nil)
		document = Document(file_id: "BQADBQADNAEAAhETzQRgwUbBAeEG7wI", thumb: nil, file_name: nil, mime_type: nil, file_size: nil)
		sticker = Sticker(file_id: "BQADBQADoAIAAmdqYwQNCKYF4l1v-gI", width: 0, height: 0, thumb: nil, emoji: nil, file_size: nil)
		video = Video(file_id: "BAADAwADHQADMV4zBNIlZtWUS2SAAg", width: 0, height: 0, duration: 0, thumb: nil, mime_type: nil, file_size: nil)
		voice = Voice(file_id: "AwADBQADMgEAAhETzQStJvo53ZGb2AI", duration: 0, mime_type: nil, file_size: nil)
		location = Location(longitude: -96.739769, latitude: 33.000869)
		venue = Venue(location: location, title: "Estates of Richardson", address: "955 W President George Bush", foursquare_id: "56d8a428cd10569560386b1e")
		contact = Contact(phone_number: "14696423333", first_name: "Shane", last_name: "Qi", user_id: 80548625)
		
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testSendMessage() {
		
		ZEGResponse.sendMessage(to: chat, text: "[testSendMessage](https://google.com)", parse_mode: .Markdown, disable_web_page_preview: true, disable_notification: true)
		
		ZEGResponse.sendMessage(to: message, text: "<a href='https://google.com'>testSendMessage</a>", parse_mode: .HTML, disable_web_page_preview: false, disable_notification: false)
	
	}
	
	func testForwardMessage() {
	
		ZEGResponse.forwardMessage(to: message, message: message, disable_notification: true)
		
	}
	
	func testSendPhoto() {
	
		ZEGResponse.sendPhoto(to: message, photo: photo, caption: "testSendPhoto", disable_notification: true)
	
	}
	
	func testSendAudio() {
	
		ZEGResponse.sendAudio(to: message, audio: audio, disable_notification: true)
	
	}
	
	func testSendDocument() {
	
		ZEGResponse.sendDocument(to: message, document: document, caption: "testSendDocument", disable_notification: true)
	
	}
	
	func testSendSticker() {
	
		ZEGResponse.sendSticker(to: message, sticker: sticker, disable_notification: true)
	
	}
	
	func testSendVideo() {
	
		ZEGResponse.sendVideo(to: message, video: video, caption: "testSendVideo", disable_notification: true)
	
	}
	
	func testSendVoice() {
	
		ZEGResponse.sendVoice(to: message, voice: voice, disable_notification: true)
	
	}
	
	func testSendLocation() {
	
		ZEGResponse.sendLocation(to: message, location: location, disable_notification: true)
	
	}
	
	func testSendVenue() {
	
		ZEGResponse.sendVenue(to: message, venue: venue, disable_notification: true)
	
	}
	
	func testSendContact() {
	
		ZEGResponse.sendContact(to: message, contact: contact, disable_notification: true)
		
	}
	
	func testSendChatAction() {
	
		ZEGResponse.sendChatAction(to: message, action: .typing)
	
	}
	
}