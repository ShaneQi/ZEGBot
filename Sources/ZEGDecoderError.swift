//
//  ZEGDecoderError.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/10/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public enum ZEGDecoderError: ErrorType {
	
	case BadInput(String)
	
	/* Request doesn't conform to format. */
	case BadRequiredFieldValue(String)
	
}