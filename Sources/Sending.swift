//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

public enum ServerStoredContent {
	case message(chatId: Int, messageId: Int)
	case sticker(fileId: String)
	case photo(fileId: String, caption: String?)
	case audio(fileId: String, caption: String?)
	case document(fileId: String, caption: String?)
	case video(fileId: String, caption: String?)
	case voice(fileId: String, caption: String?)
}

struct SendingPayload: Encodable {

	let content: Content
	let chatId: Int
	let replyToMessageId: Int?
	let disableNotification: Bool?

	enum Content {
		case serverStoredContent(ServerStoredContent)
		case message(text: String, parseMode: ParseMode?, disableWebPagePreview: Bool?)
		case location(latitude: Double, longitude: Double)
		case venue(latitude: Double, longitude: Double, title: String, address: String, foursquareId: String?)
		case contact(phoneNumber: String, firstName: String, lastName: String?)
		case chatAction(chatAction: ChatAction)
	}

	enum CodingKeys: String, CodingKey {

		case chatId = "chat_id"
		case replyToMessageId = "reply_to_message_id"
		case disableNotification = "disable_notification"

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
		case firstName = "firstName"
		case lastName = "lastName"

		// sendChatAction
		case chatAction = "action"

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(chatId, forKey: .chatId)
		if let replyToMessageId = replyToMessageId {
			try container.encode(replyToMessageId, forKey: .replyToMessageId)
		}
		if let disableNotification = disableNotification {
			try container.encode(disableNotification, forKey: .disableNotification)
		}

		switch content {
		case .serverStoredContent(let serverStoredContent):
			switch serverStoredContent {
			case .message(chatId: let chatId, messageId: let messageId):
				try container.encode(chatId, forKey: .fromChatId)
				try container.encode(messageId, forKey: .messageId)
			case .sticker(fileId: let fileId):
				try container.encode(fileId, forKey: .sticker)
			case .photo(fileId: let fileId, caption: let caption):
				try container.encode(fileId, forKey: .photo)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .audio(fileId: let fileId, caption: let caption):
				try container.encode(fileId, forKey: .audio)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .document(fileId: let fileId, caption: let caption):
				try container.encode(fileId, forKey: .document)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .video(fileId: let fileId, caption: let caption):
				try container.encode(fileId, forKey: .video)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			case .voice(fileId: let fileId, caption: let caption):
				try container.encode(fileId, forKey: .voice)
				if let caption = caption { try container.encode(caption, forKey: .caption) }
			}
		case .message(text: let text, parseMode: let parseMode, disableWebPagePreview: let disableWebPagePreview):
			try container.encode(text, forKey: .text)
			if let parseMode = parseMode { try container.encode(parseMode, forKey: .parseMode) }
			if let disableWebPagePreview = disableWebPagePreview {
				try container.encode(disableWebPagePreview, forKey: .disableWebPagePreview)
			}
		case .location(latitude: let latitude, longitude: let longitude):
			try container.encode(latitude, forKey: .latitude)
			try container.encode(longitude, forKey: .longitude)
		case .venue(latitude: let latitude, longitude: let longitude, title: let title, address: let address, foursquareId: let foursquareId):
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
			try container.encode(chatAction, forKey: .chatAction)
		}
	}

}

public protocol Sendable {

	var chatId: Int { get }
	var replyToMessageId: Int? { get }

}

extension Chat: Sendable {

	public var chatId: Int { return id }
	public var replyToMessageId: Int? { return nil }

}

extension Message: Sendable {

	public var chatId: Int { return self.chat.id }
	public var replyToMessageId: Int? { return messageId }

}
