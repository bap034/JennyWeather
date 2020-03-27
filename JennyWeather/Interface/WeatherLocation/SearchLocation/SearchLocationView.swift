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
	@State private var isShowingKeyboard = false
	
	private var keyboardOffset: CGFloat {
		let offset:CGFloat = isShowingKeyboard ? 216 : 0
		return offset
	}
	
    var body: some View {
		VStack {
			TextField("Enter Address", text: $locationVM.searchCityName, onEditingChanged: { (change) in
				self.isShowingKeyboard.toggle()
			})
				.font(.largeTitle)
				.disableAutocorrection(true)
			
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
				.padding(.bottom, keyboardOffset)
			}
		}
		.padding(20)
    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM1 = CityLocationViewModel(primaryText: "1234 Higby Street", secondaryText: "California")
		let cityLocationVM2 = CityLocationViewModel(primaryText: "Test State", secondaryText: nil)
		let cityLocationVM3 = CityLocationViewModel(primaryText: "Canada", secondaryText: nil)
		
		let locationVM = SearchLocationViewModel(cityName: "Berkeley")
		locationVM.cityLocationViewModels = [cityLocationVM1, cityLocationVM2, cityLocationVM3]
		
        return SearchLocationView(locationVM: locationVM)
    }
}
