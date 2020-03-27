//
//  SearchCompletionResultDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct SearchCompletionResultDTO: Codable {
	let primaryString: String
	let secondaryString: String?
	
	init(primaryString: String, secondaryString: String?) {
		self.primaryString = primaryString
		self.secondaryString = secondaryString
	}
}
