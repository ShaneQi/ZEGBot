//
//  Utilities.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/10/16.
//
//

public enum Result<Value> {
	case success(Value)
	case failure(Swift.Error)
}

public enum Error: Swift.Error {
	case telegram(String?)
}
