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
			
			VStack(alignment: .trailing, spacing: 10) {
				Text(locationVM.city)
					.font(.largeTitle)
					.fontWeight(.bold)
					.padding([.leading, .trailing], 20)
					.frame(alignment: .trailing)
				
				Image(systemName: "location.circle.fill")
					.resizable()
					.frame(width: 30, height: 30)
					.aspectRatio(contentMode: .fit)
					.padding([.leading, .trailing], 20)
					.onTapGesture {
						print("tapped cloud")
						// TODO: locationVM request location permission
					}
			}
		}
    }
}

struct WeatherLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let locationVM = WeatherLocationViewModel(city: "Berkeley")
		
        return WeatherLocationView(locationVM: locationVM)
    }
}
