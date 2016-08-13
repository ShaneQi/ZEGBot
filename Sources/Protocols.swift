//
//  Protocols.swift
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
        return ["chat_id": self.chat.id, "reply_to_message_id": self.message_id]
    }

}
