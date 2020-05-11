//
//  WeatherHourlyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherHourlyView: View {
    
	@ObservedObject var weatherHourlyVM: WeatherHourlyViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Hourly")
				.font(.title)
				.padding(.bottom, 10)
				.padding(.leading, 20)
			
			Text(weatherHourlyVM.summary)
				.font(.headline)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.bottom, 10)
				.padding([.leading, .trailing], 20)
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 0) {
					ForEach(weatherHourlyVM.hourVMs) { hourVM in
						HStack {
							VStack(alignment: .leading) {
								Image(systemName: hourVM.icon.systemIconName)
									.resizable()
									.scaledToFit()
									.frame(height: 30)

								Spacer()

								Text(hourVM.temperature.toTemperatureString)
									.font(.title)
							}

							VStack(alignment: .trailing) {
								Text(hourVM.timeString)
									.font(.headline)

								Spacer()

								HStack {
									Text(hourVM.precipProbability.toRainString)
									Image(systemName: WeatherIcon.rain.systemIconName)
										.resizable()
										.scaledToFit()
										.frame(maxHeight: 30)
								}

								Spacer()

								Text(hourVM.windSpeed.toWindString)
							}
							.layoutPriority(.infinity)
						}
						.padding([.leading, .trailing], 20)
						
						if hourVM.id != self.weatherHourlyVM.hourVMs.last?.id {
							Divider()
						}
					}
				}
				.padding(.bottom, 10)
			}
		}
    }
}

struct WeatherHourlyView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
		return view
    }
}
