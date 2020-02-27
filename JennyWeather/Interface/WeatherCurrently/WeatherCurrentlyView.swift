//
//  WeatherCurrentlyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/12/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherCurrentlyView: View {
	
	@ObservedObject var weatherCurrentlyVM: WeatherCurrentlyViewModel
	@ObservedObject var weatherMinutelyVM: WeatherMinutelyViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Currently")
				.font(.title)
			
			Text(weatherCurrentlyVM.timeString)
				.font(.caption)
				.padding(.bottom, 10)
			
			Text(weatherMinutelyVM.summary)
				.font(.headline)
				.padding(.bottom, 10)
			
			Text("temp: \(weatherCurrentlyVM.temperature.toTemperatureString)")
			
			Text("rain: \(weatherCurrentlyVM.precipProbability.toRainString)")
			
			Text("wind: \(weatherCurrentlyVM.windSpeed.toWindString)")
		}
    }
}

struct WeatherCurrentlyView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel, weatherMinutelyVM: weatherVM.minutelyViewModel)
		return view
    }
}
