//
//  WeatherLoadingView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherLoadingView: View {
	
	@State var error: Error? = nil
	
    var body: some View {
		Group {
			if error != nil {
				Text(error?.localizedDescription ?? "Could not connect!")
			} else {
				Text("Loading...")
			}
		}
    }
}

struct WeatherLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLoadingView()
    }
}
