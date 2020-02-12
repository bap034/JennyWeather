//
//  JWErrors.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

// MARK: - JSON Errors
struct JSONError: Error {
	enum JSONErrorType {
		case keyNotFound
		case mismatchValueType
	}
	
	let type: JSONErrorType
	let key: String
	let value: Any?
}
