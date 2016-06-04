//
//  ZEGResponse.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

public class ZEGResponse {
	
	static private var cUrl = CURL()
	static private var urlPrefix = "https://api.telegram.org/bot"+token+"/"
	
	static func sendMessage(to receiver: Receivable, text: String, parse_mode: ParseMode?, disable_web_page_preview: Bool?, disable_notification: Bool?) {
	
		var params = receiver.params
		
		params["text"] = text
		if let parse_mode = parse_mode { params["parse_mode"] = parse_mode.rawValue }
		if let disable_web_page_preview = disable_web_page_preview { params["disable_web_page_preview"] = "\(disable_web_page_preview)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
	
		performResponse("sendMessage", params: params)
		
	}
	
	static func forwardMessage(to receiver: Receivable, message: Message, disable_notification: Bool?) {
	
		var params = receiver.params
		
		params["message_id"] = "\(message.message_id)"
		params["from_chat_id"] = "\(message.chat.id)"
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("forwardMessage", params: params)
	
	}
	
	static func sendPhoto(to receiver: Receivable, photo: PhotoSize, caption: String?, disable_notification: Bool?) {
	
		var params = receiver.params
		
		params["photo"] = photo.file_id
		if let caption = caption { params["caption"] = "\(caption)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendPhoto", params: params)
	
	}
	
	static func sendAudio(to receiver: Receivable, audio: Audio, disable_notification: Bool?) {
		
		sendAudio(to: receiver, audio: audio, duration: nil, performer: nil, title: nil, disable_notification: disable_notification)
		
	}
	
	static func sendAudio(to receiver: Receivable, audio: Audio, duration: Int?, performer: String?, title: String?, disable_notification: Bool?) {
	
		var params = receiver.params
		
		params["audio"] = audio.file_id
		if let duration = duration { params["duration"] = "\(duration)" }
		if let performer = performer { params["performer"] = "\(performer)" }
		if let title = title { params["title"] = "\(title)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendAudio", params: params)
	
	}
	
	static func sendDocument(to receiver: Receivable, document: Document, caption: String?, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["document"] = document.file_id
		if let caption = caption { params["caption"] = "\(caption)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendDocument", params: params)
		
	}
	
	static func sendSticker(to receiver: Receivable, sticker: Sticker, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["sticker"] = sticker.file_id
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendSticker", params: params)
		
	}
	
	static func sendVideo(to receiver: Receivable, video: Video, caption: String?, disable_notification: Bool?) {
	
		sendVideo(to: receiver, video: video, duration: nil, width: nil, height: nil, caption: caption, disable_notification: disable_notification)
	
	}
	
	static func sendVideo(to receiver: Receivable, video: Video, duration: Int?, width: Int?, height: Int?, caption: String?, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["video"] = video.file_id
		if let duration = duration { params["duration"] = "\(duration)" }
		if let width = width { params["width"] = "\(width)" }
		if let height = height { params["height"] = "\(height)" }
		if let caption = caption { params["caption"] = "\(caption)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendVideo", params: params)
		
	}
	
	static func sendVoice(to receiver: Receivable, voice: Voice, disable_notification: Bool?) {
	
		sendVoice(to: receiver, voice: voice, duration: nil, disable_notification: disable_notification)
		
	}
	
	static func sendVoice(to receiver: Receivable, voice: Voice, duration: Int?, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["voice"] = voice.file_id
		if let duration = duration { params["duration"] = "\(duration)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendVoice", params: params)
		
	}

	static func sendLocation(to receiver: Receivable, location: Location, disable_notification: Bool?) {
	
		sendLocation(to: receiver, latitude: location.latitude, longitude: location.longitude, disable_notification: disable_notification)
	
	}
	
	static func sendLocation(to receiver: Receivable, latitude: Double, longitude: Double, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["latitude"] = "\(latitude)"
		params["longitude"] = "\(longitude)"
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendLocation", params: params)
		
	}
	
	static func sendVenue(to receiver: Receivable, venue: Venue, disable_notification: Bool?) {
	
		sendVenue(to: receiver, latitude: venue.location.latitude , longitude: venue.location.longitude, title: venue.title, address: venue.address, foursquare_id: venue.foursquare_id, disable_notification: disable_notification)
	
	}
	
	static func sendVenue(to receiver: Receivable, latitude: Double, longitude: Double, title: String, address: String, foursquare_id: String?, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["latitude"] = "\(latitude)"
		params["longitude"] = "\(longitude)"
		params["title"] = "\(title)"
		params["address"] = "\(address)"
		if let foursquare_id = foursquare_id { params["foursquare_id"] = "\(foursquare_id)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendVenue", params: params)
		
	}
	
	static func sendContact(to receiver: Receivable, contact: Contact, disable_notification: Bool?) {
	
		sendContact(to: receiver, phone_number: contact.phone_number, first_name: contact.first_name, last_name: contact.last_name, disable_notification: disable_notification)
	
	}
	
	static func sendContact(to receiver: Receivable, phone_number: String, first_name: String, last_name: String?, disable_notification: Bool?) {
		
		var params = receiver.params
		
		params["phone_number"] = "\(phone_number)"
		params["first_name"] = "\(first_name)"
		if let last_name = last_name { params["last_name"] = "\(last_name)" }
		if let disable_notification = disable_notification { params["disable_notification"] = "\(disable_notification)" }
		
		performResponse("sendContact", params: params)
		
	}
	
	static func sendChatAction(to receiver: Receivable, action: ChatAction) {
		
		var params = receiver.params
		
		params["action"] = "\(action)"
		
		performResponse("sendChatAction", params: params)
		
	}
	
	static private func performResponse(method: String, params: [String: String]) {

		var paramsStr = "?"
		
		for (field, value) in params {
			
			paramsStr += "\(field)=\(value)&"
		
		}
		
		cUrl.url = urlPrefix + method + paramsStr
		
		cUrl.performFully()
		
	}
	
}
