//
//  DarkSkyNetworkManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/27/21.
//  Copyright © 2021 Brett Petersen. All rights reserved.
//

import Foundation

class DarkSkyNetworkManager: NSObject, URLSessionDataDelegate {
	static let shared = DarkSkyNetworkManager()
	
	private var secretKey = "placeholder"
	private var baseURLString: String { return "https://api.darksky.net/forecast/\(secretKey)/" }
	private var urlSession: URLSession?
	private var observation: NSKeyValueObservation?
	
	override init() {
		super.init()
		
		let configuration = URLSessionConfiguration.default
		let delegate = self
		urlSession = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
	}
	
}

// API Methods
extension DarkSkyNetworkManager {
	func updateSecretKey(success: (()->Void)?, failure: (()->Void)?) {
		CloudKitManager.retrieveSecret { [weak self] (secret) in
			self?.secretKey = secret.darkSkyAPI
			success?()
		} failure: {
			failure?()
		}
	}
	
	/// The `urlString` parameter is appended to the `baseURLString` property. Omit leading`/` from the `urlString` value.
	func sendForecastRequest(urlString: String, completion: @escaping (Data?, URLResponse?, Error?)->Void) {
		let fullURLString = baseURLString + urlString
		guard let url = URL(string: fullURLString) else {
			let errorMessage = "Ah, sorry sorry!\n\nAn error occurred when trying to retrieve weather data. Please make sure you are on the latest app version and try again later."
			completion(nil, nil, JWError(type: .unexpectedNil, message: errorMessage))
			return
		}
		
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			completion(data, response, error)
		}
		
		observation = dataTask.progress.observe(\.fractionCompleted) { progress, _ in
			print("progress: ", progress.fractionCompleted)
		}
		dataTask.resume()
	}
}
