//
//  WeatherDataService.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

typealias DataServiceSuccess = ([String: Any])->Void
typealias DataServiceFailure = ((Error?)->Void)?

protocol WeatherDataServiceGettable {
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping DataServiceSuccess, failure: DataServiceFailure)
}

class WeatherDataService: WeatherDataServiceGettable {
	
	private let url = "https://api.darksky.net/forecast/9e81c40beac3dc5695160dec5db8258b/"
	
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping DataServiceSuccess, failure: DataServiceFailure) {
//		let higbyLatitude = 37.8267
//		let higbyLongitude = -122.28
		let urlString = "https://api.darksky.net/forecast/9e81c40beac3dc5695160dec5db8258b/\(latitude),\(longitude)"
		guard let url = URL(string: urlString) else {
			failure?(nil)
			return
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
		
		let urlSessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			print("***** WeatherDataService: \(response.debugDescription)")
			if let sureError = error {
				failure?(sureError)
			} else if let sureData = data,
				let json = try? JSONSerialization.jsonObject(with: sureData, options: []),
				let jsonDict = json as? [String: Any] {
				success(jsonDict)
			} else {
				failure?(nil)
			}
		}
		urlSessionTask.resume()
	}
}
