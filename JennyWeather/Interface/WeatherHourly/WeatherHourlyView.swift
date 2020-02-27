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
			
			Text(weatherHourlyVM.summary)
				.font(.headline)
			
			List(weatherHourlyVM.data) { data in
				VStack(alignment: .leading) {
					Text(data.timeString)
					Text("temp: \(data.temperature) ℉")
					Text("rain: \(data.precipProbability*100)%")
					Text("wind: \(data.windSpeed) mph")
				}				
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
