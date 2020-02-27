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
		VStack {
			Text("\(weatherCurrentlyVM.time)")
			
			Text(weatherMinutelyVM.summary)
			
			Text("temperature: \(weatherCurrentlyVM.temperature) ℉")
			
			Text("wind: \(weatherCurrentlyVM.windSpeed) mph")
			
			Text("precipitation: \(weatherCurrentlyVM.precipProbability * 100)%")
			
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
