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

class WeatherDataService: NSObject, URLSessionDataDelegate {
	
	private static let secretKey = "9e81c40beac3dc5695160dec5db8258b"
	private static let url = "https://api.darksky.net/forecast/\(secretKey)/"
	private var urlSession: URLSession?
	private var observation: NSKeyValueObservation?
	
	private static let unitsParameterName = "units"
	private static var unitsParameterValue: String {
		let units = UserDefaultsUtility.isUsingMetricSystem ? "si":"us"
		return units
	}
	
	override init() {
		super.init()

		let configuration = URLSessionConfiguration.default
		let delegate = self
		urlSession = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
	}
	
}

extension WeatherDataService: WeatherDataServiceGettable {
	
	private func getURL(latitude: Double, longitude: Double) -> URL? {
		let urlString = WeatherDataService.url + "\(latitude),\(longitude)"
		
		// TODO: If need more parameters, build a more robust way or use Alamofire
		let parameterString = "?" + "\(WeatherDataService.unitsParameterName)=\(WeatherDataService.unitsParameterValue)"
		let newURLString = urlString + parameterString
		
		let url = URL(string: newURLString)
		return url
	}
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping WeatherDataServiceSuccess, failure: DataServiceFailure) {
		guard let url = getURL(latitude: latitude, longitude: longitude) else {
			failure?(nil)
			return
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
		
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
		
		observation = dataTask.progress.observe(\.fractionCompleted) { progress, _ in
		  print("progress: ", progress.fractionCompleted)
		}
		dataTask.resume()
	}
}

