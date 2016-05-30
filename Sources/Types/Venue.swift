//
//  Venue.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/24/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

public struct Venue {

	var location: Location
	var title: String
	var address: String
	
	/* OPTIONAL. */
	var foursquare_id: String?
	
	init(location: Location,
	     title: String,
	     address: String,
	     foursquare_id: String?
		) {
	
		self.location = location
		self.title = title
		self.address = address
		self.foursquare_id = foursquare_id
	
	}
	
}
