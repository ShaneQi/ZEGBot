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

public protocol Identifiable {

    var identifier: [String: Any] { get }
    
}

extension PhotoSize: Identifiable {

    public var identifier: [String: Any] {
        return ["photo": self.file_id]
    }
    
}

extension Audio: Identifiable {
    
    public var identifier: [String: Any] {
        return ["audio": self.file_id]
    }
    
}

extension Document: Identifiable {
    
    public var identifier: [String: Any] {
        return ["document": self.file_id]
    }
    
}

extension Sticker: Identifiable {
    
    public var identifier: [String: Any] {
        return ["sticker": self.file_id]
    }
    
}

extension Video: Identifiable {
    
    public var identifier: [String: Any] {
        return ["video": self.file_id]
    }
    
}

extension Voice: Identifiable {
    
    public var identifier: [String: Any] {
        return ["voice": self.file_id]
    }
    
}
