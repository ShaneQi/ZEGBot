//
//  User.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/14/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct User {

	var id: Int
	var first_name: String
	
	/* OPTIONAL. */
	var last_name: String?
	var username: String?
	
	init(id: Int,
	     first_name: String,
	     last_name: String?,
	     username: String?
		) {
		
		self.id = id
		self.first_name = first_name
		self.last_name = last_name
		self.username = username

	}

}
