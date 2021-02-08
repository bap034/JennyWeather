//
//  SettingsView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/7/21.
//  Copyright © 2021 Brett Petersen. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
	
	@ObservedObject var settingsVM: SettingsViewModel
	
	/// This property is intended to be the binding for the view to the (possible) presenting view. Setting the value to `false` would
	/// indicate that the view should be dismissed.
	@Binding var isPresented: Bool
	
    var body: some View {
		ZStack {
			ThemeManager.shared.currentTheme.colors.baseLightColor
				.edgesIgnoringSafeArea(.all)
			
			VStack(alignment: .leading) {
				Text("Settings")
					.font(ThemeManager.shared.currentTheme.fonts.titleFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				
				Toggle("Use SI units", isOn: $settingsVM.isMetricSystem)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				
				Spacer()
			}
			.padding(20)
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		let isPresented:Binding<Bool> = Binding<Bool>.constant(false)
		return SettingsView(settingsVM: SettingsViewModel(), isPresented: isPresented)
    }
}
