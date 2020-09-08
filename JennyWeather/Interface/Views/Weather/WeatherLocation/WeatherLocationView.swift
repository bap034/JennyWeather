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
		HStack(spacing: 10) {
			VStack(alignment: .leading) {
				Text("Location:")
					.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					.padding(.leading, 20)
					.frame(alignment: .trailing)
				
				Text(locationVM.cityName)
					.font(ThemeManager.shared.currentTheme.fonts.headerFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
					.padding(.leading, 20)
					.frame(alignment: .trailing)
			}
			
			Spacer()
			
			Button(action: {
				self.locationVM.handlePresentingSearchLocationView()
			}) {
				Image(systemName: "magnifyingglass.circle.fill")
					.resizable()
					.frame(width: 30, height: 30)
					.aspectRatio(contentMode: .fit)
					.padding(.trailing, 20)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
			}
			.sheet(isPresented: $locationVM.canPresent) {
				SearchLocationView(locationVM: SearchLocationViewModel(cityName: ""),
								   isPresented: self.$locationVM.canPresent)
			}
		}
	}
}

struct WeatherLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let locationVM = WeatherLocationViewModel()
		
        return WeatherLocationView(locationVM: locationVM)
    }
}
