//
//  ContentView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	@ObservedObject var weatherViewModel: WeatherViewModel
	
    var body: some View {
		ScrollView {
			Text(weatherViewModel.jsonString)
				.frame(minWidth: 320)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let string = "\"summary\" : \"No precipitation throughout the week.\",\n    \"icon\" : \"clear-day\",\n    \"data\" : [\n      {\n        \"icon\" : \"clear-day\",\n        \"windGustTime\" : 1581278460,\n        \"temperatureLowTime\" : 1581344280,\n        \"dewPoint\" : 24.75,\n        \"summary\" : \"Clear throughout the day.\",\n        \"temperatureMax\" : 63.109999999999999,\n        \"humidity\" : 0.31,\n        \"windGust\" : 37.579999999999998,\n        \"precipIntensityMax\" : 0.002,\n        \"cloudCover\" : 0,\n        \"ozone\" : 329,\n        \"apparentTemperatureMinTime\" : 1581249180,\n        \"precipIntensityMaxTime\" : 1581307200,\n        \"sunriseTime\" : 1581260820,\n        \"precipIntensity\" : 0.00089999999999999998,\n        \"windSpeed\" : 13.199999999999999,\n        \"apparentTemperatureHighTime\" : 1581293820,\n        \"apparentTemperatureMin\" : 50.079999999999998,\n        \"apparentTemperatureHigh\" : 62.609999999999999,\n        \"apparentTemperatureLowTime\" : 1581344820,\n        \"precipProbability\" : 0.040000000000000001,\n        \"temperatureHighTime\" : 1581293820,\n        \"pressure\" : 1017.3,\n        \"sunsetTime\" : 1581298920,\n        \"windBearing\" : 0,\n        \"temperatureMinTime\" : 1581249180,\n        \"temperatureLow\" : 48.289999999999999,\n        \"temperatureHigh\" : 63.109999999999999,\n        \"uvIndexTime\" : 1581279780,\n        \"apparentTemperatureMax\" : 62.609999999999999,\n        \"apparentTemperatureMaxTime\" : 1581293820,\n        \"visibility\" : 10,\n        \"moonPhase\" : 0.53000000000000003,\n        \"apparentTemperatureLow\" : 45.329999999999998,\n        \"time\" : 1581235200,\n        \"precipType\" : \"rain\",\n        \"uvIndex\" : 3,\n        \"temperatureMin\" : 49.590000000000003,\n        \"temperatureMaxTime\" : 1581293820\n"
		
		let weatherVM = WeatherViewModel()
		weatherVM.jsonString = string
		let view = ContentView(weatherViewModel: weatherVM)
		return view
    }
}
