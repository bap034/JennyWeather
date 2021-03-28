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
	
	private var secretKey = "9e81c40beac3dc5695160dec5db8258b"
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
	/// The `urlString` parameter is appended to the `baseURLString` property. Omit leading`/` from the `urlString` value.
	func sendForecastRequest(urlString: String, completion: @escaping (Data?, URLResponse?, Error?)->Void) {
		let fullURLString = baseURLString + urlString
		guard let url = URL(string: fullURLString) else {
			completion(nil, nil, JWError.unexpectedNil)
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
