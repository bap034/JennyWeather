//
//  String+JW.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/12/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

extension String {
	func toJson() throws -> [String: Any] {
		guard let jsonData = data(using: .utf8) else { throw JWError.unexpectedNil }
		let jsonAnyObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
		guard let json = jsonAnyObject as? [String: Any] else { throw JWError.unexpectedNil }
		
		return json
	}
}
