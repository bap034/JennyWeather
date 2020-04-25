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
		
		let minutelyText = weatherMinutelyVM.summary ?? weatherCurrentlyVM.summary
		
		return HStack {
			VStack(alignment: .leading) {
				Text("Currently")
					.font(.title)
					.padding([.leading, .trailing], 20)
				
				Text(weatherCurrentlyVM.timeString)
					.font(.caption)
					.padding(.bottom, 10)
					.padding([.leading, .trailing], 20)
				
				Text(minutelyText)
					.font(.headline)
					.fixedSize(horizontal: false, vertical: true)
					.padding(.bottom, 10)
					.padding([.leading, .trailing], 20)
				
				Text("temp: \(weatherCurrentlyVM.temperature.toTemperatureString)")
					.padding([.leading, .trailing], 20)
				
				Text("rain: \(weatherCurrentlyVM.precipProbability.toRainString)")
					.padding([.leading, .trailing], 20)
				
				Text("wind: \(weatherCurrentlyVM.windSpeed.toWindString)")
					.padding([.leading, .trailing], 20)
			}
			
			Spacer()
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
