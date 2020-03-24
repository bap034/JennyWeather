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

class WeatherDataService: NSObject, URLSessionDataDelegate {
	
	private static let secretKey = "9e81c40beac3dc5695160dec5db8258b"
	private static let url = "https://api.darksky.net/forecast/\(secretKey)/"
	private var urlSession: URLSession?
	private var observation: NSKeyValueObservation?
	
	override init() {
		super.init()

		let configuration = URLSessionConfiguration.default
		let delegate = self
		urlSession = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
	}
	
}

extension WeatherDataService: WeatherDataServiceGettable {
	func getWeatherData(latitude: Double, longitude: Double, success: @escaping DataServiceSuccess, failure: DataServiceFailure) {
		let urlString = WeatherDataService.url + "\(latitude),\(longitude)"
		guard let url = URL(string: urlString) else {
			failure?(nil)
			return
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)		
		
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
		
		observation = dataTask.progress.observe(\.fractionCompleted) { progress, _ in
		  print("progress: ", progress.fractionCompleted)
		}
		dataTask.resume()
	}
}

