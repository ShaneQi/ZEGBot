//
//  Chat.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/11/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct Chat {

	var id: Int
	var type: String
	
	/* Optional. */
	var title: String?
	var username: String?
	var first_name: String?
	var last_name: String?
	
	init(id: Int,
	     type: String,
	     title: String?,
	     username: String?,
	     first_name: String?,
	     last_name: String?) {
	
		self.id = id
		self.type = type
		self.title = title
		self.username = username
		self.first_name = first_name
		self.last_name = last_name
		
	}
	
	/* Conform to Receivable. */
	lazy public var recipientIdentification: [String : String] = {
		
		var recipientIdentification = [String : String]()
		recipientIdentification["chat_id"] = "\(self.id)"
		return recipientIdentification
		
	} ()
	
}
