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
			Text(cityLocationVM.primaryString)
				.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			
			if (!cityLocationVM.secondaryString.isEmpty) {
				Text(cityLocationVM.secondaryString)
					.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			}
		}
    }
}

struct CityLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM = CityLocationViewModel(primaryString: "1234 Higby Street", secondaryString: "Canada")
        return CityLocationView(cityLocationVM: cityLocationVM)
    }
}
