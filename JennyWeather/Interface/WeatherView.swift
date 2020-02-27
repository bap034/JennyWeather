//
//  WeatherView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
	
	@ObservedObject var weatherVM: WeatherViewModel
	
	var body: some View {
		ScrollView {
			WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel, weatherMinutelyVM: weatherVM.minutelyViewModel)
				.padding([.top, .bottom], 30)
			
			Divider()
			
			WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
		}
	}
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		let view = WeatherView(weatherVM: weatherVM)
		return view
	}
}
