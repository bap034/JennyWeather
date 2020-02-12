//
//  ContentView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	@ObservedObject var weatherViewModel: WeatherViewModel
	
    var body: some View {
		if let sureWeatherDayViewModel = weatherViewModel.dayViewModel {
			return ScrollView {
				Text(sureWeatherDayViewModel.summary)
					.frame(minWidth: 320)
			}
		} else {
			return ScrollView {
				Text(weatherViewModel.text)
					.frame(minWidth: 320)
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let dayString = """
{
      "summary":"Mixed precipitation throughout the week, with temperatures falling to 39°F on Saturday.",
      "icon":"rain",
      "data":[
         {
            "time":1509944400,
            "summary":"Rain starting in the afternoon, continuing until evening.",
            "icon":"rain",
            "sunriseTime":1509967519,
            "sunsetTime":1510003982,
            "moonPhase":0.59,
            "precipIntensity":0.0088,
            "precipIntensityMax":0.0725,
            "precipIntensityMaxTime":1510002000,
            "precipProbability":0.73,
            "precipType":"rain",
            "temperatureHigh":66.35,
            "temperatureHighTime":1509994800,
            "temperatureLow":41.28,
            "temperatureLowTime":1510056000,
            "apparentTemperatureHigh":66.53,
            "apparentTemperatureHighTime":1509994800,
            "apparentTemperatureLow":35.74,
            "apparentTemperatureLowTime":1510056000,
            "dewPoint":57.66,
            "humidity":0.86,
            "pressure":1012.93,
            "windSpeed":3.22,
            "windGust":26.32,
            "windGustTime":1510023600,
            "windBearing":270,
            "cloudCover":0.8,
            "uvIndex":2,
            "uvIndexTime":1509987600,
            "visibility":10,
            "ozone":269.45,
            "temperatureMin":52.08,
            "temperatureMinTime":1510027200,
            "temperatureMax":66.35,
            "temperatureMaxTime":1509994800,
            "apparentTemperatureMin":52.08,
            "apparentTemperatureMinTime":1510027200,
            "apparentTemperatureMax":66.53,
            "apparentTemperatureMaxTime":1509994800
         }
      ]
   }
"""
		
		let weatherVM = WeatherViewModel()
		weatherVM.text = dayString
		
		if let dayStringJsonData = dayString.data(using: .utf8),
			let dayStringJson = try? JSONSerialization.jsonObject(with: dayStringJsonData, options: []) as? [String: Any] {
			let weatherDayVM = try? WeatherDailyViewModel(json: dayStringJson)
			weatherVM.dayViewModel = weatherDayVM
		}
		
		let view = ContentView(weatherViewModel: weatherVM)
		return view
    }
}
