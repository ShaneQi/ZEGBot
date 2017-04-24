//
//  Methods.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectCURL
import cURL
import SwiftyJSON
import Foundation

extension ZEGBot {
	
	@discardableResult
	public func send(message text: String, to receiver: Sendable,
	                 parseMode: ParseMode? = nil,
	                 disableWebPagePreview: Bool = false,
	                 disableNotification: Bool = false) -> Message? {
		
		var payload: [String: Any] = [
			PARAM.TEXT: text,
			]
		
		if let parseMode = parseMode { payload[PARAM.PARSE_MODE] = parseMode.rawValue }
		if disableWebPagePreview { payload[PARAM.DISABLE_WEB_PAGE_PREVIEW] = true }
		
		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
		payload.append(contentOf: receiver.receiverIdentifier)
		
		guard let responseJSON = perform(method: PARAM.SEND_MESSAGE, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
		
	}
	
	@discardableResult
	public func forward(message: Message, to receiver: Sendable,
	                    disableNotification: Bool = false) -> Message? {
		
		var payload: [String: Any] = [
			PARAM.MESSAGE_ID: message.message_id,
			PARAM.FROM_CHAT_ID: message.chat.id
		]
		
		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
		payload.append(contentOf: receiver.receiverIdentifier)
		
		guard let responseJSON = perform(method: PARAM.FORWARD_MESSAGE, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
		
	}
	
	@discardableResult
	public func send(photo: PhotoSize, to receiver: Sendable,
	                 disableNotification: Bool = false,
	                 caption: String? = nil) -> Message? {
		
		var options = [String: Any]()
		
		options[PARAM.CAPTION] = caption
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: photo, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func send(audio: Audio, to receiver: Sendable,
	                 disableNotification: Bool = false) -> Message? {
		
		var options = [String: Any]()
		
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: audio, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func send(document: Document, to receiver: Sendable,
	                 disableNotification: Bool = false,
	                 caption: String? = nil) -> Message? {
		
		var options = [String: Any]()
		
		options[PARAM.CAPTION] = caption
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: document, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func send(sticker: Sticker, to receiver: Sendable,
	                 disableNotification: Bool = false) -> Message? {
		
		var options = [String: Any]()
		
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: sticker, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func send(video: Video, to receiver: Sendable,
	                 disableNotification: Bool = false) -> Message? {
		
		var options = [String: Any]()
		
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: video, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func send(voice: Voice, to receiver: Sendable,
	                 disableNotification: Bool = false) -> Message? {
		
		var options = [String: Any]()
		
		if disableNotification { options[PARAM.DISABLE_NOTIFICATION] = true }
		
		return send(contentOnServer: voice, to: receiver, options: options)
		
	}
	
	@discardableResult
	public func sendLocation(latitude: Double, longitude: Double, to receiver: Sendable,
	                         disableNotification: Bool = false) -> Message? {
		
		var payload: [String: Any] = [
			PARAM.LATITUDE: latitude,
			PARAM.LONGITUDE: longitude
		]
		
		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
		payload.append(contentOf: receiver.receiverIdentifier)
		
		guard let responseJSON = perform(method: PARAM.SEND_LOCATION, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
	}
	
	@discardableResult
	public func sendVenue(latitude: Double, longitude: Double,
	                      title: String, address: String, foursquare_id: String? = nil,
	                      to receiver: Sendable,
	                      disableNotification: Bool = false) -> Message? {
		
		var payload: [String: Any] = [
			PARAM.LATITUDE: latitude,
			PARAM.LONGITUDE: longitude,
			PARAM.TITLE: title,
			PARAM.ADDRESS: address
		]
		let optionalPayload: [String: Any?] = [
			PARAM.FOURSQUARE_ID: foursquare_id
		]
		payload.append(contentOf: optionalPayload)
		
		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
		payload.append(contentOf: receiver.receiverIdentifier)
		
		guard let responseJSON = perform(method: PARAM.SEND_VENUE, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
		
	}
	
	@discardableResult
	public func sendContact(phoneNumber: String, lastName: String, firstName: String? = nil,
	                        to receiver: Sendable,
	                        disableNotification: Bool = false) -> Message? {
		
		var payload: [String: Any] = [
			PARAM.PHONE_NUMBER: phoneNumber,
			PARAM.LAST_NAME: lastName
		]
		let optionalPayload: [String: Any?] = [
			PARAM.FIRST_NAME: firstName
		]
		payload.append(contentOf: optionalPayload)
		
		if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
		payload.append(contentOf: receiver.receiverIdentifier)
		
		guard let responseJSON = perform(method: PARAM.SEND_CONTACT, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
		
	}

	public func send(chatAction: ChatAction, to receiver: Sendable) {
		
		var payload: [String: Any] = [
			PARAM.ACTION: chatAction.rawValue
		]
		
		payload.append(contentOf: receiver.receiverIdentifier)
		
		let _ = perform(method: PARAM.SEND_CHAT_ACTION, payload: payload)
		
	}

	public func getFile(ofId fileId: String) -> File? {

		let payload: [String: Any] = [
			PARAM.FILE_ID: fileId
		]

		guard let responseJSON = perform(method: PARAM.GET_FILE, payload: payload) else {
			return nil
		}

		return File(from: responseJSON[PARAM.RESULT])

	}
	
}

extension ZEGBot {
	
	internal func send(contentOnServer content: Identifiable, to receiver: Sendable,
	                   options: [String: Any]) -> Message? {
		
		var payload = [String: Any]()
		
		payload.append(contentOf: content.identifier)
		payload.append(contentOf: receiver.receiverIdentifier)
		payload.append(contentOf: options)
		
		guard let responseJSON = perform(method: content.sendingMethod, payload: payload) else {
			return nil
		}
		
		return Message(from: responseJSON[PARAM.RESULT])
		
	}
	
	internal func perform(method: String, payload: [String: Any]) -> JSON? {
		
		guard var bodyBytes = JSON(payload).rawString()?.bytes() else {
			Log.warning(onMethod: method)
			return nil
		}
		
		let curl = CURL()
		curl.url = urlPrefix + method
		curl.setOption(CURLOPT_POSTFIELDS, v: &bodyBytes)
		curl.setOption(CURLOPT_HTTPHEADER, s: PARAM.POST_JSON_HEADER_CONTENT_TYPE)
		
		return JSON(data: Data(bytes: curl.performFully().2))
		
	}
	
}
