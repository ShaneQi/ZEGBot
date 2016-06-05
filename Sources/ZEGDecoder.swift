//
//  ZEGDecoder.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/10/16.
//  Copyright © 2016 Shane. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

public class ZEGDecoder {
	
	static func decodeUpdate(jsonString: String) -> Update? {
		
		do {
		
			let jsonConvertibleObject = try jsonString.zegJsonDecode()
			return try decodeUpdate(jsonConvertibleObject)
		
		} catch {
			
			return nil
		
		}
		
	}
	
	static func decodeUpdate(jsonConvertibleObject: Any?) throws -> Update {
		
		guard jsonConvertibleObject != nil else {
		
			throw ZEGDecoderError.BadInput("Input is empty.")
		
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")

		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		/* update_id. */
		guard let update_id = jsonDictionary["update_id"] as? Int else {

			throw ZEGDecoderError.BadRequiredFieldValue("Field 'update_id'.")

		}
		
		/* OPTIONAL */
		let message: Message? = decodeMessage(jsonDictionary["message"])
		let edited_message: Message? = decodeMessage(jsonDictionary["edited_message"])
		
		return Update(update_id: update_id, message: message, edited_message: edited_message)
		
	}
	
	static func decodeMessage(jsonConvertibleObject: Any?) -> Message? {
		
		do {
		
			let message: Message = try decodeMessage(jsonConvertibleObject)
			return message
		
		} catch {

			return nil
		
		}
		
	}
	
	static func decodeMessage(jsonConvertibleObject: Any?) throws -> Message {

		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		/* message_id. */
		guard let message_id = jsonDictionary["message_id"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'message_id'.")
			
		}
		
		/* date. */
		guard let date = jsonDictionary["date"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'date'.")
			
		}
		
		/* chat. */
		var chat: Chat
		do {
			
			chat = try decodeChat(jsonDictionary["chat"])
			
		} catch let e {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'date': \(e)")
			
		}
		
		/* OPTIONAL. */
		let from: User? = decodeUser(jsonDictionary["from"])
		let forward_from: User? = decodeUser(jsonDictionary["forward_from"])
		let forward_from_chat: Chat? = decodeChat(jsonDictionary["forward_from_chat"])
		let forward_date = jsonDictionary["forward_date"] as? Int
		let reply_to_message: Message? = decodeMessage(jsonDictionary["reply_to_message"])
		let edit_date = jsonDictionary["edit_date"] as? Int
		let text = jsonDictionary["text"] as? String
		let entities: [MessageEntity]? = decodeMessageEntitiesArray(jsonDictionary["entities"])
		let audio: Audio? = decodeAudio(jsonDictionary["audio"])
		let document: Document? = decodeDocument(jsonDictionary["document"])
		let photo: [PhotoSize]? = decodePhotoSizeArray(jsonDictionary["photo"])
		let sticker: Sticker? = decodeSticker(jsonDictionary["sticker"])
		let video: Video? = decodeVideo(jsonDictionary["video"])
		let voice: Voice? = decodeVoice(jsonDictionary["voice"])
		let caption = jsonDictionary["caption"] as? String
		let contact: Contact? = decodeContact(jsonDictionary["contact"])
		let location: Location? = decodeLocation(jsonDictionary["location"])
		let venue: Venue? = decodeVenue(jsonDictionary["venue"])
		let new_chat_member: User? = decodeUser(jsonDictionary["new_chat_member"])
		let left_chat_member: User? = decodeUser(jsonDictionary["left_chat_member"])
		let new_chat_title = jsonDictionary["new_chat_title"] as? String
		let new_chat_photo: [PhotoSize]? = decodePhotoSizeArray(jsonDictionary["new_chat_photo"])
		let delete_chat_photo = jsonDictionary["delete_chat_photo"] as? Bool
		let group_chat_created = jsonDictionary["group_chat_created"] as? Bool
		let supergroup_chat_created = jsonDictionary["supergroup_chat_created"] as? Bool
		let channel_chat_created = jsonDictionary["channel_chat_created"] as? Bool
		let migrate_to_chat_id = jsonDictionary["migrate_to_chat_id"] as? Int
		let migrate_from_chat_id = jsonDictionary["migrate_from_chat_id"] as? Int
		let pinned_message: Message? = decodeMessage(jsonDictionary["pinned_message"])
		
		return Message(message_id: message_id, date: date, chat: chat, from: from, forward_from: forward_from, forward_from_chat: forward_from_chat, forward_date: forward_date, reply_to_message: reply_to_message, edit_date: edit_date, text: text, entities: entities, audio: audio, document: document, photo: photo, sticker: sticker, video: video, voice: voice, caption: caption, contact: contact, location: location, venue: venue, new_chat_member: new_chat_member, left_chat_member: left_chat_member, new_chat_title: new_chat_title, new_chat_photo: new_chat_photo, delete_chat_photo: delete_chat_photo, group_chat_created: group_chat_created, supergroup_chat_created: supergroup_chat_created, channel_chat_created: channel_chat_created, migrate_to_chat_id: migrate_to_chat_id, migrate_from_chat_id: migrate_from_chat_id, pinned_message: pinned_message)
	
	}
	
	static func decodeChat(jsonConvertibleObject: Any?) -> Chat? {
	
		do {
			
			let chat: Chat = try decodeChat(jsonConvertibleObject)
			return chat
			
		} catch {
	
			return nil
		
		}
	
	}
	
	static func decodeChat(jsonConvertibleObject: Any?) throws -> Chat {
	
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		/* id. */
		guard let id = jsonDictionary["id"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'id'.")
			
		}
	
		/* type. */
		guard let type = jsonDictionary["type"] as? String else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'type'.")
			
		}
		
		/* OPTIONAL. */
		let title = jsonDictionary["title"] as? String
		let username = jsonDictionary["username"] as? String
		let first_name = jsonDictionary["first_name"] as? String
		let last_name = jsonDictionary["last_name"] as? String
		
		return Chat(id: id, type: type, title: title, username: username, first_name: first_name, last_name: last_name)
	
	}
	
	static func decodeUser(jsonConvertibleObject: Any?) -> User? {
	
		do {
		
			let user: User = try decodeUser(jsonConvertibleObject)
			return user
		
		} catch {
	
			return nil
		
		}
	
	}
	
	static func decodeUser(jsonConvertibleObject: Any?) throws -> User {
		
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		/* id. */
		guard let id = jsonDictionary["id"] as? Int else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'id'.")
		
		}
		
		/* first_name. */
		guard let first_name = jsonDictionary["first_name"] as? String else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'first_name'.")
			
		}
		
		/* OPTIONAL. */
		let last_name = jsonDictionary["last_name"] as? String
		let username = jsonDictionary["username"] as? String
		
		return User(id: id, first_name: first_name, last_name: last_name, username: username)
	
	}
	
	static func decodeMessageEntitiesArray(jsonConvertibleObject: Any?) -> [MessageEntity]? {
	
		do {
		
			let messageEntitiesArray: [MessageEntity] = try decodeMessageEntitiesArray(jsonConvertibleObject)
			return messageEntitiesArray
		
		} catch {
		
			return nil
			
		}
		
	}
	
	static func decodeMessageEntitiesArray(jsonConvertibleObject: Any?) throws -> [MessageEntity] {
		
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonArray = jsonConvertibleObject as! [Any]
		var messageEntitiesArray = [MessageEntity]()
		
		for entity in jsonArray {
		
			do {
				
				guard entity is JSONConvertible else {
				
					throw ZEGDecoderError.BadInput("Input type is incorrect.")
				
				}
				
				let messageEntity: MessageEntity = try decodeMessageEntity(entity)
				messageEntitiesArray.append(messageEntity)
			
			} catch let e {
			
				throw e
			
			}
		
		}
		
		return messageEntitiesArray
	
	}
	
	static func decodeMessageEntity(jsonConvertibleObject: Any?) throws -> MessageEntity {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		/* type. */
		guard let type = jsonDictionary["type"] as? String else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'type'.")
			
		}
		
		/* offset. */
		guard let offset = jsonDictionary["offset"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'offset'.")
			
		}
		
		/* length. */
		guard let length = jsonDictionary["length"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'length'.")
			
		}
		
		/* OPTIONAL. */
		let url = jsonDictionary["url"] as? String

		return MessageEntity(type: type, offset: offset, length: length, url: url)
		
	}
	
	static func decodeAudio(jsonConvertibleObject: Any?) -> Audio? {
		
		do {
		
			let audio: Audio = try decodeAudio(jsonConvertibleObject)
			return audio
		
		} catch {
			
			return nil
		
		}
		
	}
	
	static func decodeAudio(jsonConvertibleObject: Any?) throws -> Audio {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		guard let duration = jsonDictionary["duration"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'duration'.")
			
		}
		
		/* OPTIONAL. */
		let performer = jsonDictionary["performer"] as? String
		let title = jsonDictionary["title"] as? String
		let mime_type = jsonDictionary["mime_type"] as? String
		let file_size = jsonDictionary["file_size"] as? Int
	
		return Audio(file_id: file_id, duration: duration, performer: performer, title: title, mime_type: mime_type, file_size: file_size)
		
	}
	
	static func decodeDocument(jsonConvertibleObject: Any?) -> Document? {
	
		do {
		
			let document: Document = try decodeDocument(jsonConvertibleObject)
			return document
		
		} catch {
		
			return nil
		
		}
	
	}
	
	static func decodeDocument(jsonConvertibleObject: Any?) throws -> Document {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
	
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		/* OPTIONAL. */
		let thumb: PhotoSize? = decodePhotoSize(jsonDictionary["thumb"])
		let file_name = jsonDictionary["file_name"] as? String
		let mime_type = jsonDictionary["mime_type"] as? String
		let file_size = jsonDictionary["file_size"] as? Int
		
		return Document(file_id: file_id, thumb: thumb, file_name: file_name, mime_type: mime_type, file_size: file_size)
		
	}
	
	static func decodePhotoSize(jsonConvertibleObject: Any?) -> PhotoSize? {
	
		do {
			
			let photoSize: PhotoSize = try decodePhotoSize(jsonConvertibleObject)
			return photoSize
			
		} catch {
	
			return nil
			
		}
	
	}
	
	static func decodePhotoSizeArray(jsonConvertibleObject: Any?) -> [PhotoSize]? {
		
		do {
			
			let photoSizeArray: [PhotoSize] = try decodePhotoSizeArray(jsonConvertibleObject)
			return photoSizeArray
			
		} catch {

			return nil
			
		}
		
	}
	
	static func decodePhotoSizeArray(jsonConvertibleObject: Any?) throws -> [PhotoSize] {
		
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonArray = jsonConvertibleObject as! [Any]
		var photoSizeArray = [PhotoSize]()
		
		for photoSizeObject in jsonArray {
			
			do {
				
				let photoSize: PhotoSize = try decodePhotoSize(photoSizeObject)
				photoSizeArray.append(photoSize)
				
			} catch let e {
				
				throw e
				
			}
			
		}
		
		return photoSizeArray
	}
	
	static func decodePhotoSize(jsonConvertibleObject: Any?) throws -> PhotoSize {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		guard let width = jsonDictionary["width"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'width'.")
			
		}
		
		guard let height = jsonDictionary["height"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'height'.")
			
		}
		
		let file_size = jsonDictionary["file_size"] as? Int
		
		return PhotoSize(file_id: file_id, width: width, height: height, file_size: file_size)
		
	}
	
	static func decodeSticker(jsonConvertibleObject: Any?) -> Sticker? {
	
		do {
		
			let sticker: Sticker = try decodeSticker(jsonConvertibleObject)
			return sticker
		
		} catch {
	
			return nil
		
		}
	
	}
	
	static func decodeSticker(jsonConvertibleObject: Any?) throws -> Sticker {
	
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		guard let width = jsonDictionary["width"] as? Int else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'width'.")
		
		}
		
		guard let height = jsonDictionary["height"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'height'.")
			
		}
		
		let thumb: PhotoSize? = decodePhotoSize(jsonDictionary["thumb"])
		let emoji: String? = jsonDictionary["emoji"] as? String
		let file_size: Int? = jsonDictionary["file_size"] as? Int
		
		return Sticker(file_id: file_id, width: width, height: height, thumb: thumb, emoji: emoji, file_size: file_size)
		
	}
	
	static func decodeVideo(jsonConvertibleObject: Any?) -> Video? {
	
		do {
		
			let video: Video = try decodeVideo(jsonConvertibleObject)
			return video
		
		} catch {

			return nil
		
		}
	
	}
	
	static func decodeVideo(jsonConvertibleObject: Any?) throws -> Video {
	
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		guard let width = jsonDictionary["width"] as? Int else {

			throw ZEGDecoderError.BadRequiredFieldValue("Field 'width'.")
			
		}
		
		guard let height = jsonDictionary["height"] as? Int else {
			
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'height'.")
			
		}
		
		guard let duration = jsonDictionary["duration"] as? Int else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'duration'.")
		
		}
		
		let thumb: PhotoSize? = decodePhotoSize(jsonDictionary["thumb"])
		let mime_type: String? = jsonDictionary["mime_type"] as? String
		let file_size: Int? = jsonDictionary["file_size"] as? Int
		
		return Video(file_id: file_id, width: width, height: height, duration: duration, thumb: thumb, mime_type: mime_type, file_size: file_size)
	
	}
	
	static func decodeVoice(jsonConvertibleObject: Any?) -> Voice? {
	
		do {
		
			let voice: Voice = try decodeVoice(jsonConvertibleObject)
			return voice
		
		} catch {
		
			return nil
		
		}
	
	}
	
	static func decodeVoice(jsonConvertibleObject: Any?) throws -> Voice {
	
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let file_id = jsonDictionary["file_id"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'file_id'.")
		
		}
		
		guard let duration = jsonDictionary["duration"] as? Int else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'duration'.")
		
		}
		
		let mime_type = jsonDictionary["mime_type"] as? String
		let file_size = jsonDictionary["file_size"] as? Int
		
		return Voice(file_id: file_id, duration: duration, mime_type: mime_type, file_size: file_size)
	
	}
	
	static func decodeContact(jsonConvertibleObject: Any?) -> Contact? {
	
		do {
		
			let contact: Contact = try decodeContact(jsonConvertibleObject)
			return contact
		
		} catch {
		
			return nil
		
		}
	
	}
	
	static func decodeContact(jsonConvertibleObject: Any?) throws -> Contact {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let phone_number = jsonDictionary["phone_number"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'phone_number'.")
			
		}
		
		guard let first_name = jsonDictionary["first_name"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'first_name'.")
		
		}
		
		let last_name = jsonDictionary["last_name"] as? String
		let user_id = jsonDictionary["user_id"] as? Int
	
		return Contact(phone_number: phone_number, first_name: first_name, last_name: last_name, user_id: user_id)
		
	}
	
	static func decodeLocation(jsonConvertibleObject: Any?) -> Location? {
	
		do {
		
			let location: Location = try decodeLocation(jsonConvertibleObject)
			return location
		
		} catch {
		
			return nil
		
		}
	
	}
	
	static func decodeLocation(jsonConvertibleObject: Any?) throws -> Location {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		guard let longitude = jsonDictionary["longitude"] as? Double else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'longitude'.")
			
		}
		
		guard let latitude = jsonDictionary["latitude"] as? Double else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'latitude'.")
		
		}
		
		return Location(longitude: longitude, latitude: latitude)
	
	}
	
	static func decodeVenue(jsonConvertibleObject: Any?) -> Venue? {
	
		do {
			
			let venue: Venue = try decodeVenue(jsonConvertibleObject)
			return venue
			
		} catch {
		
			return nil
			
		}
	
	}
	
	static func decodeVenue(jsonConvertibleObject: Any?) throws -> Venue {
		
		guard jsonConvertibleObject != nil else {
			
			throw ZEGDecoderError.BadInput("Input is empty.")
			
		}
		
		guard (jsonConvertibleObject is [String: Any]) else {
			
			throw ZEGDecoderError.BadInput("Input type is incorrect.")
			
		}
		
		let jsonDictionary = jsonConvertibleObject as! [String: Any]
		
		var location: Location
		do {
		
			location = try decodeLocation(jsonDictionary["location"])
		
		} catch let e {
		
			throw e
		
		}
		
		guard let title = jsonDictionary["title"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'title'.")
		
		}
		
		guard let address = jsonDictionary["address"] as? String else {
		
			throw ZEGDecoderError.BadRequiredFieldValue("Field 'address'.")
		
		}
		
		let foursquare_id = jsonDictionary["foursquare_id"] as? String
		
		return Venue(location: location, title: title, address: address, foursquare_id: foursquare_id)
	
	}
	
}

public enum ZEGDecoderError: ErrorType {
	
	case BadInput(String)
	case BadRequiredFieldValue(String)
	
}

