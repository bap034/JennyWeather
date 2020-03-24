//
//  SearchLocationView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct SearchLocationView: View {
	
	@ObservedObject var locationVM: SearchLocationViewModel
	
    var body: some View {
		VStack {
			HStack {
				TextField("Enter Address", text: $locationVM.searchCityName)
					.font(.largeTitle)
				
				Button(action: {
					self.locationVM.searchAddress(self.locationVM.searchCityName)
				}) {
					Text("Search!")
				}
			}
			
			if locationVM.isError {
				HStack {
					Text("Something went wrong. Please try again.")
						.padding([.top, .leading], 10)
					Spacer()
				}
				Spacer()
			} else if locationVM.isEmpty {
				HStack {
					Text("No results found.")
						.padding([.top, .leading], 10)
					Spacer()
				}
				Spacer()
			} else {
				List(locationVM.cityLocationViewModels) { (cityLocationVM) in
					CityLocationView(cityLocationVM: cityLocationVM)
				}
			}
		}
    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM1 = CityLocationViewModel(streetAddress: "123 Test St.")
		let cityLocationVM2 = CityLocationViewModel(streetAddress: "456 Test St.")
		let cityLocationVM3 = CityLocationViewModel(streetAddress: "Canada")
		
		let locationVM = SearchLocationViewModel(cityName: "Berkeley")
		locationVM.cityLocationViewModels = [cityLocationVM1, cityLocationVM2, cityLocationVM3]
		
        return SearchLocationView(locationVM: locationVM)
    }
}
