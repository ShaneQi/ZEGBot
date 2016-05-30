//
//  MessageEntity.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/16/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct MessageEntity {

	var type: String
	var offset: Int
	var length: Int
	
	/* OPTIONAl. */
	var url: String?

	init(type: String,
	     offset: Int,
	     length: Int,
	     url: String?
		){
	
		self.type = type
		self.offset = offset
		self.length = length
		self.url = url
	
	}
	
}
