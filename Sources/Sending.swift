//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

import Foundation

public enum ServerStoredContent {

	public enum Location {

		case telegramServer(fileId: String)
		case internet(url: URL)

		var payload: String {
			switch self {
			case .telegramServer(fileId: let fileId):
				return fileId
			case .internet(url: let url):
				return url.absoluteString
			}
		}

	}

	case sticker(location: Location)
	case photo(location: Location, caption: String?)
	case audio(location: Location, caption: String?)
	case document(location: Location, caption: String?)
	case video(location: Location, caption: String?)
	case voice(location: Location, caption: String?)

	fileprivate var methodName: String {
		switch self {
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

struct SendingPayload: Encodable {

	let content: Content
	let chatId: Int
	let replyToMessageId: Int?
	let disableNotification: Bool?
	let replyMarkup: InlineKeyboardMarkup?

	enum Content {
		case serverStoredContent(ServerStoredContent)
		case forwardableMessage(chatId: Int, messageId: Int)
		case message(text: String, parseMode: ParseMode?, disableWebPagePreview: Bool?)
		case location(latitude: Double, longitude: Double)
		case venue(latitude: Double, longitude: Double, title: String, address: String, foursquareId: String?)
		case contact(phoneNumber: String, firstName: String, lastName: String?)
		case chatAction(chatAction: ChatAction)
	}

	var methodName: String {
		switch content {
		case .serverStoredContent(let serverStoredContent):
			return serverStoredContent.methodName
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
		case .serverStoredContent(let serverStoredContent):
			switch serverStoredContent {
			case .sticker(location: let location):
				try container.encode(location.payload, forKey: .sticker)
			case .photo(location: let location, caption: let caption):
				try container.encode(location.payload, forKey: .photo)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .audio(location: let location, caption: let caption):
				try container.encode(location.payload, forKey: .audio)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .document(location: let location, caption: let caption):
				try container.encode(location.payload, forKey: .document)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .video(location: let location, caption: let caption):
				try container.encode(location.payload, forKey: .video)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .voice(location: let location, caption: let caption):
				try container.encode(location.payload, forKey: .voice)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
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
