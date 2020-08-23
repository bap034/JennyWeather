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
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				HStack {
					VStack(alignment: .leading) {
						Text("Currently")
							.font(.title)
						
						Text(weatherCurrentlyVM.timeString)
							.font(.footnote)
							.padding(.bottom, 10)
					}
					
					Spacer()
					
					Image(systemName: weatherCurrentlyVM.icon.systemIconName)
						.resizable()
						.scaledToFit()
						.frame(height: 50)
				}
				
				Text(weatherCurrentlyVM.minutelyText)
					.font(.headline)
					.fixedSize(horizontal: false, vertical: true)
					.padding(.bottom, 10)
				
				HStack {
					Text(weatherCurrentlyVM.temperature.toTemperatureString)
						.font(.title)
					
					Text(weatherCurrentlyVM.precipProbability.toRainString)
					
					Text(weatherCurrentlyVM.windSpeed.toWindString)
				}
			}
			.padding([.leading, .trailing], 20)
			
			Spacer()
		}
    }
}

struct WeatherCurrentlyView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel)
		return view
    }
}
