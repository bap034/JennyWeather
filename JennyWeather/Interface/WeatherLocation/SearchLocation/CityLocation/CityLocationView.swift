//
//  CityLocationView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct CityLocationView: View {
	
	@ObservedObject var cityLocationVM: CityLocationViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(cityLocationVM.primaryText)
				.font(.headline)
			
			if (!cityLocationVM.secondaryText.isEmpty) {
				Text(cityLocationVM.secondaryText)
					.font(.subheadline)
			}
		}
    }
}

struct CityLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM = CityLocationViewModel(primaryText: "1234 Higby Street", secondaryText: "Canada")
        return CityLocationView(cityLocationVM: cityLocationVM)
    }
}
