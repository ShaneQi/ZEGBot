//
//  Updating.swift
//  ZEGBot
//
//  Created by Shane Qi on 3/20/20.
//

struct UpdatingPayload: Encodable {

	enum NewContent {
		case text(newText: String, parseMode: ParseMode?, disableWebPagePreview: Bool?)
		case caption(newCaption: String, parseMode: ParseMode?)
	}

	let messageId: Int
	let chatId: Int
	let newContent: NewContent

	private enum CodingKeys: String, CodingKey {
		case messageId = "message_id"
		case chatId = "chat_id"
		case text
		case caption
		case parseMode = "parse_mode"
		case disableWebPagePreview = "disable_web_page_preview"
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(messageId, forKey: .messageId)
		try container.encode(chatId, forKey: .chatId)
		switch newContent {
		case .text(newText: let newText, parseMode: let parseMode, disableWebPagePreview: let disableWebPagePreview):
			try container.encode(newText, forKey: .text)
			try container.encodeIfPresent(parseMode, forKey: .parseMode)
			try container.encodeIfPresent(disableWebPagePreview, forKey: .disableWebPagePreview)
		case .caption(newCaption: let newCaption, parseMode: let parseMode):
			try container.encode(newCaption, forKey: .caption)
			try container.encodeIfPresent(parseMode, forKey: .parseMode)
		}
	}

}
