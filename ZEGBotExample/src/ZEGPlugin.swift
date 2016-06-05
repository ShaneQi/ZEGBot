//
//  ZEGPlugin.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 6/4/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

#if os(Linux)
	import SwiftGlibc
#else
	import Darwin
#endif

class ZEGBotPlugin {
	
	static func distance(between A: Location, and B: Location) -> Double{
		
		func degreeToRadius(degree: Double) -> Double{
			
			let radius: Double = degree * 3.1415926 / 180
			return radius
			
		}
		
		let latA = A.latitude
		let lonA = A.longitude
		let latB = B.latitude
		let lonB = B.longitude
		let R: Double = 3956
		
		let degreeLat = degreeToRadius((latA - latB))
		let degreeLon = degreeToRadius((lonA - lonB))
		
		let a = sin(degreeLat/2) * sin(degreeLat/2) +
			cos(degreeToRadius(latA)) * cos(degreeToRadius(latB)) *
			sin(degreeLon/2) * sin(degreeLon/2)
		
		let c = atan2(sqrt(a), sqrt(1 - a)) * 2
		return R * c
		
	}
	
	
}