//
//  TypeExtension.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/30/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

/* Protocol. */
protocol Receivable {
	
	var params: [String: String] { get }
	
}

/* Extension protocol. */
extension Chat: Receivable {
	
	var params: [String: String] { return ["chat_id": "\(self.id)"] }
	
}

extension Message: Receivable {
	
	var params: [String: String] { return ["chat_id": "\(self.chat.id)", "reply_to_message_id": "\(self.message_id)"] }
	
}

/* Support types. */
enum ParseMode: String {
	
	case Markdown
	case HTML
	
}


enum ChatAction: String {
	
	case typing
	case upload_photo
	case record_video
	case upload_video
	case record_audio
	case upload_audio
	case upload_document
	case find_location
	
}
