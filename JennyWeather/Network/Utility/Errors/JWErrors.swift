//
//  JWErrors.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

// MARK: - JW Errors
enum JWError: Error {
	case unexpectedNil
}

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

// MARK: - Location Errors
struct LocationError: Error {
	enum LocationErrorType {
		case noResults
		case other
	}
	
	let type: LocationErrorType
}
