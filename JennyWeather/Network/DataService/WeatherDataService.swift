//
//  WeatherDataService.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

typealias WeatherDataServiceSuccess = (WeatherDTO)->Void
typealias DataServiceFailure = ((Error?)->Void)?

protocol WeatherDataServiceGettable {
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping WeatherDataServiceSuccess, failure: DataServiceFailure)
}

class WeatherDataService: NSObject {
	
	private static let unitsParameterName = "units"
	private static var unitsParameterValue: String {
		let units = UserDefaultsUtility.isUsingMetricSystem ? "si":"us"
		return units
	}
	
}

extension WeatherDataService: WeatherDataServiceGettable {
	
	private func getURLString(latitude: Double, longitude: Double) -> String {
		let urlString = "\(latitude),\(longitude)"
		
		// TODO: If need more parameters, build a more robust way or use Alamofire
		let parameterString = "?" + "\(WeatherDataService.unitsParameterName)=\(WeatherDataService.unitsParameterValue)"
		let newURLString = urlString + parameterString
		return newURLString
	}
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping WeatherDataServiceSuccess, failure: DataServiceFailure) {
		let urlString = getURLString(latitude: latitude, longitude: longitude)
		
		DarkSkyNetworkManager.shared.sendForecastRequest(urlString: urlString) { (data, response, error) in
			if let sureData = data,
				let json = try? JSONSerialization.jsonObject(with: sureData, options: []),
				let jsonDict = json as? [String: Any] {
				do {
					let weatherDTO:WeatherDTO = try NetworkUtility.codableFromJSON(jsonDict)
					
					// TODO: can this be moved to somewhere else?
					if FunManager.shared.shouldIncrementCandiceSpecialValue(currentTemperature: weatherDTO.currently.temperature) {
						FunManager.shared.incrementCandiceSpecialValue()						
					}
					
					success(weatherDTO)
				} catch {
					failure?(error)
				}
			} else {
				failure?(error)
			}
		}
	}
}

