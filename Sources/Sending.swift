//
//  Sending.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/12/16.
//
//

public protocol Sendable {
	
	var receiverIdentifier: [String: Any] { get }
	
}

extension Chat: Sendable {
 
	public var receiverIdentifier: [String: Any] {
		return ["chat_id": self.id]
	}
	
}

extension Message: Sendable {
	
	public var receiverIdentifier: [String: Any] {
		return ["chat_id": self.chat.id, "reply_to_message_id": self.messageId]
	}
	
}

public protocol Identifiable {
	
	var identifier: [String: Any] { get }
	var sendingMethod: String { get }
	
}

extension PhotoSize: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.PHOTO: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_PHOTO }
	
}

extension Audio: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.AUDIO: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_AUDIO }
	
}

extension Document: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.DOCUMENT: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_DOCUMENT }
	
}

extension Sticker: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.STICKER: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_STICKER }
	
}

extension Video: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.VIDEO: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_VIDEO }
	
}

extension Voice: Identifiable {
	
	public var identifier: [String: Any] {
		return [ZEGBot.PARAM.VOICE: self.fileId]
	}
	
	public var sendingMethod: String { return ZEGBot.PARAM.SEND_VOICE }
	
}
