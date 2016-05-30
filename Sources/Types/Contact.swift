//
//  Contact.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/24/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct Contact {

	var phone_number: String
	var first_name: String
	
	/* OPTIONAL. */
	var last_name: String?
	var user_id: Int?
	
	init(phone_number: String,
	     first_name: String,
	     last_name: String?,
	     user_id: Int?
	) {
	
		self.phone_number = phone_number
		self.first_name = first_name
		self.last_name = last_name
		self.user_id = user_id
	
	}
	
}
