//
//  WeatherAlertViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherAlertViewModel: ObservableObject {
	
	private let dto: WeatherAlertDTO
	
	@Published var title: String
	@Published var timestamp: Int
	@Published var expiresTimestamp: Int
	@Published var description: String
	@Published var uri: String
	@Published var time: Date
	@Published var expiresTime: Date
	
	init(dto: WeatherAlertDTO) {
		self.dto = dto
		
		title = dto.title
		timestamp = dto.timestamp
		expiresTimestamp = dto.expiresTimestamp
		description = dto.description
		uri = dto.uri
		time = dto.time
		expiresTime = dto.expiresTime
	}
	
}
