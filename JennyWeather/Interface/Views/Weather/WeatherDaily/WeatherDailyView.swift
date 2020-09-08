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
				.padding(.leading, 20)
			
			Text(weatherDailyVM.summary)
				.font(.headline)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.bottom, 10)
				.padding([.leading, .trailing], 20)
			
			ForEach(weatherDailyVM.dayVMs) { (dayVM) in
				VStack(alignment: .leading) {
					Text(dayVM.timeString)
						.font(.headline)
					HStack {
						VStack {
							Image(systemName: dayVM.icon.systemIconName)
								.resizable()
								.scaledToFit()
								.frame(width: 50, height: 30)
							
							if dayVM.icon == .rain {
								Text(dayVM.precipProbability.toRainString)
							}
						}
						
						Divider()
						
						Text(dayVM.temperatureHigh.toTemperatureString)
							.font(.title)
						Text(dayVM.temperatureLow.toTemperatureString)
						
						Divider()
						
						Text(dayVM.windSpeed.toWindString)
					}
				}
				
				Divider()
			}
			.padding([.leading, .trailing], 20)
		}
    }
}

struct WeatherDailyView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
		return view
    }
}
