//
//  Sticker.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/14/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct Sticker {

	var file_id: String
	var width: Int
	var height: Int
	
	/* Optional. */
	var thumb: PhotoSize?
	var emoji: String?
	var file_size: Int?

	init(file_id: String,
	     width: Int,
	     height: Int,
	     thumb: PhotoSize?,
	     emoji: String?,
	     file_size: Int?
		) {
	
		self.file_id = file_id
		self.width = width
		self.height = height
		self.thumb = thumb
		self.emoji = emoji
		self.file_size = file_size
		
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendSticker"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["sticker"] = self.file_id
		return content
	}
	
}