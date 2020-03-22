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
		Text(cityLocationVM.streetAddress)
    }
}

struct CityLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM = CityLocationViewModel(streetAddress: "1234 Higby Street")
        return CityLocationView(cityLocationVM: cityLocationVM)
    }
}
