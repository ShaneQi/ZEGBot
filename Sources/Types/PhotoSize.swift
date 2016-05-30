//
//  PhotoSize.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/13/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct PhotoSize {
	
	var file_id: String
	var width: Int
	var height: Int
	
	/* Optional. */
	var file_size: Int?
	
	init(file_id: String,
	     width: Int,
	     height: Int,
	     file_size: Int?){
	
		self.file_id = file_id
		self.width = width
		self.height = height
		self.file_size = file_size
	
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendPhoto"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["photo"] = self.file_id
		return content
	}
	
}
