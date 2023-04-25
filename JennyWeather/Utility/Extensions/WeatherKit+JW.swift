//
//  WeatherKit+JW.swift
//  JennyWeather
//
//  Created by Brett Petersen on 4/20/23.
//  Copyright © 2023 Brett Petersen. All rights reserved.
//

import Foundation
import WeatherKit

// MARK: - PrecipitationType
enum PrecipitationType: Codable {
    case hail   // A form of precipitation consisting of solid ice.
    case mixed  // Mixed precipitation.
    case rain   // Rain.
    case sleet  // A form of precipitation consisting of ice pellets.
    case snow   // Snow.
    case none
    
    /// Manually added
    case unknown
    
    init(wkPrecipitation: Precipitation) {
        switch wkPrecipitation {
            case .hail:
                self = .hail
            case .mixed:
                self = .mixed
            case .rain:
                self = .rain
            case .sleet:
                self = .sleet
            case .snow:
                self = .snow
            case .none:
                self = .none
            @unknown default:
                self = .unknown
        }
    }
    
    var isPrecipitating: Bool {
        let isNotNone = self != .none
        let isNotUnknown = self != .unknown
        return isNotNone && isNotUnknown
    }
}

// MARK: - Weather
extension Weather {
    var toWeatherDTO: WeatherDTO {
        let alerts = weatherAlerts?.map({ $0.toWeatherAlertDTOs })
        let minutely = minuteForecast?.toWeatherMinutelyDTO
        let hourly = hourlyForecast.toWeatherHourlyDTO
        let daily = dailyForecast.toWeatherDailyDTO
        let currently = currentWeather.toWeatherCurrentlyDTO
        let weatherDTO = WeatherDTO(alerts: alerts,
                                    minutely: minutely,
                                    hourly: hourly,
                                    daily: daily,
                                    currently: currently)
        return weatherDTO
    }
}

// MARK: - WeatherAlert
extension WeatherAlert {
    var toWeatherAlertDTOs: WeatherAlertDTO {
        // Does not actually use alerts...
        let alertDTO = WeatherAlertDTO(region: region,
                                       severity: severity.description,
                                       summary: summary,
                                       detailsUrl: detailsURL,
                                       source: source)
        return alertDTO
    }
}
// MARK: - MinuteWeather
extension Forecast<MinuteWeather> {
    var toWeatherMinutelyDTO: WeatherMinutelyDTO {
        let minuteWeathers = forecast
        /// Only taking the first minute data for the current `precipitationChance`
        let minuteDTOs = minuteWeathers.map { minuteWeather in
            let minuteDTO = WeatherMinuteDTO(precipType: PrecipitationType(wkPrecipitation: minuteWeather.precipitation),
                                             precipProbability: minuteWeather.precipitationChance,
                                             time: minuteWeather.date)
            return minuteDTO
        }
        let minutelyDTO = WeatherMinutelyDTO(summary: summary,
                                             data: minuteDTOs)
        return minutelyDTO
    }
}
// MARK: - HourWeather
extension Forecast<HourWeather> {
    var toWeatherHourlyDTO: WeatherHourlyDTO {
        let hourWeathers = forecast
        let hourDTOs = hourWeathers.map { hourWeather in
            let hourDTO = WeatherHourDTO(icon: hourWeather.symbolName,
                                         precipType: PrecipitationType(wkPrecipitation: hourWeather.precipitation),
                                         precipProbability: hourWeather.precipitationChance,
                                         temperature: hourWeather.temperature,
                                         windSpeed: hourWeather.wind.speed,
                                         time: hourWeather.date)
            return hourDTO
        }
        let hourlyDTO = WeatherHourlyDTO(data: hourDTOs)
        return hourlyDTO
    }
}
// MARK: - DayWeather
extension Forecast<DayWeather> {
    var toWeatherDailyDTO: WeatherDailyDTO {
        let dayWeathers = forecast
        let dailyDTOs = dayWeathers.map { dayWeather in
            let dayDTO = WeatherDayDTO(icon: dayWeather.symbolName,
                                       precipType: PrecipitationType(wkPrecipitation: dayWeather.precipitation),
                                       precipProbability: dayWeather.precipitationChance,
                                       temperatureHigh: dayWeather.highTemperature,
                                       temperatureLow: dayWeather.lowTemperature,
                                       windSpeed: dayWeather.wind.speed,
                                       time: dayWeather.date)
            return dayDTO
        }
        let dailyDTO = WeatherDailyDTO(data: dailyDTOs)
        return dailyDTO
    }
}
// MARK: - CurrentWeather
extension CurrentWeather {
    var toWeatherCurrentlyDTO: WeatherCurrentlyDTO {
//        let currentlyDTO = WeatherCurrentlyDTO(icon: symbolName,
//                                               temperature: temperature.toLocaleValue,
//                                               temperatureUnit: temperature.toLocaleUnit,
//                                               windSpeed: wind.speed.toLocaleValue,
//                                               windSpeedUnit: wind.speed.toLocaleUnit,
//                                               time: date)
        let currentlyDTO = WeatherCurrentlyDTO(icon: symbolName,
                                               temperature: temperature,
                                               windSpeed: wind.speed,
                                               time: date)
        return currentlyDTO
    }
}
