//
//  SearchCompletionResultDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct SearchCompletionResultDTO: Codable {
	let primaryText: String
	let secondaryText: String?
	
	init(primaryText: String, secondaryText: String?) {
		self.primaryText = primaryText
		self.secondaryText = secondaryText
	}
}
