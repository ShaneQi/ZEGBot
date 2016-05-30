//
//  Video.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/21/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct Video {

	var file_id: String
	var width: Int
	var height: Int
	var duration: Int
	
	/* OPTIONAL. */
	var thumb: PhotoSize?
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     width: Int,
	     height: Int,
	     duration: Int,
	     thumb: PhotoSize?,
	     mime_type: String?,
	     file_size: Int?
		){
		
		self.file_id = file_id
		self.width = width
		self.height = height
		self.duration = duration
		self.thumb = thumb
		self.mime_type = mime_type
		self.file_size = file_size
		
	}

}
