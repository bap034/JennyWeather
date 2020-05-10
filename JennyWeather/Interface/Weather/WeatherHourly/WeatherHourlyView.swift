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
				HStack {
					ForEach(weatherHourlyVM.hourVMs) { hourVM in
						VStack(alignment: .leading) {
							Text(hourVM.timeString)
								.font(.headline)
							Text("temp: \(hourVM.temperature.toTemperatureString)")
							Text("rain: \(hourVM.precipProbability.toRainString)")
							Text("wind: \(hourVM.windSpeed.toWindString)")
						}
						.frame(minWidth: 150)
						
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
