//
//  Audio.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/17/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct Audio {

	var file_id: String
	var duration: Int
	
	/* OPTIONAL. */
	var performer: String?
	var title: String?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     duration: Int,
	     performer: String?,
	     title: String?,
	     mime_type: String?,
	     file_size: Int?
		) {
	
		self.file_id = file_id
		self.duration = duration
		self.performer = performer
		self.title = title
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
}
