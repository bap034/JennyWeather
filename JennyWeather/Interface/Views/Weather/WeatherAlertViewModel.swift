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
	
	@Published var region: String?
	@Published var severity: String
	@Published var summary: String
	@Published var detailsUrl: URL
	@Published var source: String
	
	init(dto: WeatherAlertDTO) {
		self.dto = dto
		
        region = dto.region
        severity = dto.severity
        summary = dto.summary
        detailsUrl = dto.detailsUrl
        source = dto.source
	}
	
}
