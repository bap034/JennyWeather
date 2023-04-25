//
//  WeatherKitManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/3/23.
//  Copyright © 2023 Brett Petersen. All rights reserved.
//

import CoreLocation
import Foundation
import WeatherKit

class WeatherKitManager {
    private static let service = WeatherService.shared
    
    static func getWeatherDTO(latitude: Double, longitude: Double) async -> Result<WeatherDTO, Error> {
        let result = await getWeather(latitude: latitude, longitude: longitude)
        switch result {
            case .success(let weather):
//                if let data = try? JSONEncoder().encode(weather),
//                   let jsonString = String(data: data, encoding: .utf8) {
//                    print(jsonString)
//                }
                
                let weatherDTO = weather.toWeatherDTO
                return .success(weatherDTO)
                
            case .failure(let error):
                return .failure(error)
        }
    }
    
    private static func getWeather(latitude: Double, longitude: Double) async -> Result<Weather, Error> {
        let location = CLLocation(latitude: CLLocationDegrees(latitude),
                                  longitude: CLLocationDegrees(longitude))
        do {
            let weather = try await service.weather(for: location)
            return .success(weather)
        } catch {
            return .failure(error)
        }
    }
}


// MARK: - String Getters
extension WeatherKitManager {
    static func getPrecipProbabilityText(precipProbability: Double) -> String {
        let rainString = String(format: "%.0f%%", precipProbability*100)
        return rainString
    }
}
