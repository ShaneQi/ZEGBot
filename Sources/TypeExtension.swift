//
//  TypeExtension.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

extension Chat: Receivable {

	var params: [String: String] { return ["chat_id": "\(self.id)"] }

}

extension Message: Receivable {

	var params: [String: String] { return ["chat_id": "\(self.chat.id)", "reply_to_message_id": "\(self.message_id)"] }
	
}