//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

import Foundation

public struct Resource {

	public enum Location: Encodable {

		case telegramServer(fileId: String)
		case internet(url: URL)
		case local(path: String)

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .telegramServer(fileId: let fileId):
				try container.encode(fileId)
			case .internet(url: let url):
				try container.encode(url.absoluteString)
			case .local:
				throw EncodingError.invalidValue(self, EncodingError.Context(
					codingPath: container.codingPath,
					debugDescription: "Local content can't be encoded, it should be sent via multipart."))
			}
		}

	}

	public enum `Type` {
		case sticker
		case photo
		case audio
		case document
		case video
		case voice
	}

	public let location: Location
	public let type: `Type`
	public let caption: String?

	fileprivate var methodName: String {
		switch self.type {
		case .audio:
			return "sendAudio"
		case .document:
			return "sendDocument"
		case .photo:
			return "sendPhoto"
		case .sticker:
			return "sendSticker"
		case .video:
			return "sendVideo"
		case .voice:
			return "sendVoice"
		}
	}
}

struct SendingPayload {

	let content: Content
	let chatId: Int
	let replyToMessageId: Int?
	let disableNotification: Bool?
	let replyMarkup: InlineKeyboardMarkup?

	enum Content {
		case resource(Resource)
		case forwardableMessage(chatId: Int, messageId: Int)
		case message(text: String, parseMode: ParseMode?, disableWebPagePreview: Bool?)
		case location(latitude: Double, longitude: Double)
		case venue(latitude: Double, longitude: Double, title: String, address: String, foursquareId: String?)
		case contact(phoneNumber: String, firstName: String, lastName: String?)
		case chatAction(chatAction: ChatAction)
	}

	var methodName: String {
		switch content {
		case .resource(let resource):
			return resource.methodName
		case .forwardableMessage:
			return "forwardMessage"
		case .message:
			return "sendMessage"
		case .location:
			return "sendLocation"
		case .venue:
			return "sendVenue"
		case .contact:
			return "sendContact"
		case .chatAction:
			return "sendChatAction"
		}
	}
}

extension SendingPayload: Encodable {

	private enum CodingKeys: String, CodingKey {

		case chatId = "chat_id"
		case replyToMessageId = "reply_to_message_id"
		case disableNotification = "disable_notification"
		case replyMarkup = "reply_markup"

		// sendMessage
		case text
		case parseMode = "parse_mode"
		case disableWebPagePreview = "disable_web_page_preview"

		// forwardMessage
		case fromChatId = "from_chat_id"
		case messageId = "message_id"

		case sticker
		case caption, photo, audio, document, video, voice, location, venue, contact

		// sendLocation
		case latitude, longitude

		// sendVenue
		case address, title
		case foursquareId = "foursquare_id"

		// sendContact
		case phoneNumber = "phone_number"
		case firstName = "first_name"
		case lastName = "last_name"

		// sendChatAction
		case action

	}

	// swiftlint:disable cyclomatic_complexity
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(chatId, forKey: .chatId)
		if let replyToMessageId = replyToMessageId {
			try container.encode(replyToMessageId, forKey: .replyToMessageId)
		}
		if let disableNotification = disableNotification {
			try container.encode(disableNotification, forKey: .disableNotification)
		}
		if let replyMarkup = replyMarkup {
			try container.encode(replyMarkup, forKey: .replyMarkup)
		}

		switch content {
		case .resource(let resource):
			switch resource.type {
			case .sticker:
				try container.encode(resource.location, forKey: .sticker)
			case .photo:
				try container.encode(resource.location, forKey: .photo)
			case .audio:
				try container.encode(resource.location, forKey: .audio)
			case .document:
				try container.encode(resource.location, forKey: .document)
			case .video:
				try container.encode(resource.location, forKey: .video)
			case .voice:
				try container.encode(resource.location, forKey: .voice)
			}
			if case .sticker = resource.type {
			} else if let caption = resource.caption {
				try container.encode(caption, forKey: .caption)
			}
		case .forwardableMessage(chatId: let chatId, messageId: let messageId):
			try container.encode(chatId, forKey: .fromChatId)
			try container.encode(messageId, forKey: .messageId)
		case .message(text: let text, parseMode: let parseMode, disableWebPagePreview: let disableWebPagePreview):
			try container.encode(text, forKey: .text)
			if let parseMode = parseMode { try container.encode(parseMode, forKey: .parseMode) }
			if let disableWebPagePreview = disableWebPagePreview {
				try container.encode(disableWebPagePreview, forKey: .disableWebPagePreview)
			}
		case .location(latitude: let latitude, longitude: let longitude):
			try container.encode(latitude, forKey: .latitude)
			try container.encode(longitude, forKey: .longitude)
		case .venue(
			latitude: let latitude, longitude: let longitude, title: let title,
			address: let address, foursquareId: let foursquareId):
			try container.encode(latitude, forKey: .latitude)
			try container.encode(longitude, forKey: .longitude)
			try container.encode(title, forKey: .title)
			try container.encode(address, forKey: .address)
			if let foursquareId = foursquareId { try container.encode(foursquareId, forKey: .foursquareId) }
		case .contact(phoneNumber: let phoneNumber, firstName: let firstName, lastName: let lastName):
			try container.encode(phoneNumber, forKey: .phoneNumber)
			try container.encode(firstName, forKey: .firstName)
			if let lastName = lastName { try container.encode(lastName, forKey: .lastName) }
		case .chatAction(chatAction: let chatAction):
			try container.encode(chatAction, forKey: .action)
		}
	}

}

extension SendingPayload: MultipartEncodable {

	func encode(withBoundary boundary: String) throws -> Data {
		guard case .resource(let resource) = self.content else {
			fatalError("Only resource payload could be encoded to multipart.")
		}
		guard case .local(let path) = resource.location else {
			fatalError("Only resource at a local path could be encoded to multipart.")
		}
		guard let url = URL(string: path) else {
			throw Error.input("Not a valid path: \(path)")
		}
		let fileName = url.lastPathComponent
		var data = Data()
		let fileData = try NSData(contentsOfFile: path) as Data
		switch resource.type {
		case .sticker:
			append(key: "sticker", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		case .photo:
			append(key: "photo", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		case .audio:
			append(key: "audio", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		case .document:
			append(key: "document", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		case .video:
			append(key: "video", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		case .voice:
			append(key: "voice", value: fileData, to: &data, boundary: boundary, fileName: fileName)
		}

		append(key: "chat_id", value: "\(chatId)".data(using: .utf8)!, to: &data, boundary: boundary)

		if let replyToMessageId = replyToMessageId {
			append(key: "reply_to_message_id", value: "\(replyToMessageId)".data(using: .utf8)!, to: &data, boundary: boundary)
		}
		if let disableNotification = disableNotification {
			append(key: "disable_notification", value: "\(disableNotification)".data(using: .utf8)!, to: &data, boundary: boundary)
		}
		if let replyMarkup = replyMarkup {
			append(key: "reply_markup", value: try JSONEncoder().encode(replyMarkup), to: &data, boundary: boundary)
		}

		if case .sticker = resource.type {
		} else if let caption = resource.caption {
			append(key: "caption", value: caption.data(using: .utf8)!, to: &data, boundary: boundary)
		}

		data.append("--\(boundary)--".data(using: .utf8)!)
		return data
	}

	private func append(key: String, value: Data, to data: inout Data, boundary: String, fileName: String? = nil) {
		data.append("--\(boundary)\r\n".data(using: .utf8)!)
		data.append("Content-Disposition: form-data; name=\"\(key)\"".data(using: .utf8)!)
		if let fileName = fileName {
			data.append("; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
		}
		data.append("\r\n".data(using: .utf8)!)
		data.append("\r\n".data(using: .utf8)!)
		data.append(value)
		data.append("\r\n".data(using: .utf8)!)

	}

}

public protocol Sendable {

	var chatId: Int { get }

}

public protocol Replyable: Sendable {

	var replyToMessageId: Int? { get }

}

extension Chat: Sendable {

	public var chatId: Int { return id }

}

extension Message: Sendable, Replyable {

	public var chatId: Int { return chat.id }
	public var replyToMessageId: Int? { return messageId }

}

public protocol ForwardableMessage {

	var chatId: Int { get }
	var messageId: Int { get }

}

extension Message: ForwardableMessage {}
