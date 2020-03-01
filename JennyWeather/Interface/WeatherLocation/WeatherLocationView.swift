//
//  WeatherLocationView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/1/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherLocationView: View {
	
	@ObservedObject var locationVM: WeatherLocationViewModel
	
    var body: some View {
		
		HStack {
			Spacer()
			
			Text(locationVM.city)
				.font(.largeTitle)
				.fontWeight(.bold)
				.frame(alignment: .leading)
				.padding([.leading, .trailing], 20)
		}
    }
}

struct WeatherLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let locationVM = WeatherLocationViewModel(city: "Berkeley")
		
        return WeatherLocationView(locationVM: locationVM)
    }
}
