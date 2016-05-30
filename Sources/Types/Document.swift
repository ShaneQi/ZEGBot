//
//  Document.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/19/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct Document {

	var file_id: String
	
	/* OPTIONAL. */
	var thumb: PhotoSize?
	var file_name: String?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     thumb: PhotoSize?,
	     file_name: String?,
	     mime_type: String?,
	     file_size: Int?
		) {
	
		self.file_id = file_id
		self.thumb = thumb
		self.file_name = file_name
		self.mime_type = mime_type
		self.file_size = file_size
	
	}

}
