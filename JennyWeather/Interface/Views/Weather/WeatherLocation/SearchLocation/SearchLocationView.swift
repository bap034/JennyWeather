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
		
	/// This property is intended to be the binding for the view to the (possible) presenting view. Setting the value to `false` would
	/// indicate that the view should be dismissed.
	@Binding var isPresented: Bool
	
	@State private var isShowingKeyboard = false
	
	private var keyboardOffset: CGFloat {
		let offset:CGFloat = isShowingKeyboard ? 216 : 0
		return offset
	}
	
	init(locationVM: SearchLocationViewModel, isPresented: Binding<Bool>) {
		self.locationVM = locationVM
		self._isPresented = isPresented
		
		/// Used to remove default `white` background color:  https://stackoverflow.com/a/58427518
		UITableView.appearance().backgroundColor = .clear
		UITableViewCell.appearance().backgroundColor = .clear
	}
	
    var body: some View {
		ZStack {
			ThemeManager.shared.currentTheme.colors.baseLightColor
				.edgesIgnoringSafeArea(.all)
		
			VStack {
				TextField("Enter Address", text: $locationVM.searchCityName, onEditingChanged: { (isEditing) in
					self.isShowingKeyboard = isEditing
				})
					.font(ThemeManager.shared.currentTheme.fonts.titleFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					.disableAutocorrection(true)
				
				if locationVM.isError {
					HStack {
						Text("Something went wrong. Please try again.")
							.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							.padding([.top, .leading], 10)
						Spacer()
					}
					Spacer()
				} else if locationVM.isEmpty {
					HStack {
						Text("No results found.")
							.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							.padding([.top, .leading], 10)
						Spacer()
					}
					Spacer()
				} else {
					List(locationVM.cityLocationViewModels) { (cityLocationVM) in
						CityLocationView(cityLocationVM: cityLocationVM)
							.onTapGesture {
								self.locationVM.select(cityLocationVM.combinedString)
								self.isPresented = false
							}
					}
					.padding(.bottom, keyboardOffset)
				}
			}
			.padding(20)
		}
    }
}

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
		let cityLocationVM1 = CityLocationViewModel(primaryString: "1234 Higby Street", secondaryString: "California")
		let cityLocationVM2 = CityLocationViewModel(primaryString: "Test State", secondaryString: nil)
		let cityLocationVM3 = CityLocationViewModel(primaryString: "Canada", secondaryString: nil)
		
		let locationVM = SearchLocationViewModel(cityName: "Berkeley")
		locationVM.cityLocationViewModels = [cityLocationVM1, cityLocationVM2, cityLocationVM3]
		
		let isPresented:Binding<Bool> = Binding<Bool>.constant(false)
        return SearchLocationView(locationVM: locationVM, isPresented: isPresented)
    }
}
