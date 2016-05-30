//
//  Voice.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/14/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct Voice {

	var file_id: String
	var duration: Int
	
	/* Optional. */
	var mime_type: String?
	var file_size: Int?
	
	init(file_id: String,
	     duration: Int,
	     mime_type: String?,
	     file_size: Int?
		) {
		
		self.file_id = file_id
		self.duration = duration
		self.mime_type = mime_type
		self.file_size = file_size
		
	}
	
	/* Conform to Sendable. */
	public var method: String {
		return "sendVoice"
	}
	
	public var contentIdentification: [String: String] {
		var content = [String: String]()
		content["voice"] = self.file_id
		return content
	}
	
}
