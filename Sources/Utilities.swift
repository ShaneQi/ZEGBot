//
//  Utilities.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/10/16.
//
//

import Foundation

public enum Result<T>: Decodable where T: Decodable {

	case success(T)
	case failure(Swift.Error)

	enum CodingKeys: String, CodingKey {
		case ok, result, description
	}

	public init(from decoder: Decoder) {
		do {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			switch try container.decode(Bool.self, forKey: .ok) {
			case true:
				self = .success(try container.decode(T.self, forKey: .result))
			case false:
				self = .failure(Error.telegram(try container.decode(String.self, forKey: .description)))
			}
		} catch(let error) {
			self = .failure(error)
		}
	}

	static func decode(from data: Data) -> Result {
		do {
			return try JSONDecoder().decode(Result.self, from: data)
		} catch(let error) {
			return .failure(error)
		}
	}

}

public enum Error: Swift.Error {
	case telegram(String?)
}
