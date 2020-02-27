//
//  WeatherDailyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherDailyView: View {
    @ObservedObject var weatherDailyVM: WeatherDailyViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Daily")
				.font(.title)
				.padding(.bottom, 10)
			
			Text(weatherDailyVM.summary)
				.font(.headline)
				.padding(.bottom, 10)
			
			ForEach(weatherDailyVM.data) { (data) in
				VStack(alignment: .leading) {
					Text(data.timeString)
						.font(.headline)
					Text("high: \(data.temperatureHigh.toTemperatureString)")
					Text("low: \(data.temperatureLow.toTemperatureString)")
					Text("rain: \(data.precipProbability.toRainString)")
					Text("wind: \(data.windSpeed.toWindString)")
				}
				
				Divider()
			}
		}
		.padding(.leading, 20)
    }
}

struct WeatherDailyView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
		return view
    }
}
