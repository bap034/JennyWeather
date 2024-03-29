//
//  SceneDelegate.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

		let themeType = ThemeType.rain // TODO: make this fetch the appropriate theme based on weather
		let isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
		ThemeManager.shared.currentTheme = ThemeManager.getTheme(themeType: themeType, isDarkMode: isDarkMode)
		
		// Create the SwiftUI view that provides the window contents.
		let weatherLoadingView = WeatherLoadingView()
			
		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
		    window.rootViewController = UIHostingController(rootView: weatherLoadingView)
		    self.window = window
		    window.makeKeyAndVisible()
		}
		
		// TODO: Move this somewhere more appropriate?
		let locationManager = LocationManager.shared
		guard let sureLatitude = locationManager.currentPlacemark.latitude, let sureLongitude = locationManager.currentPlacemark.longitude else {
			let errorMessage = "Ack!\n\nSomething went wrong. Please make sure you are on the latest app version and try again later."
			let newWeatherLoadingView = WeatherLoadingView(error: JWError(type: .unexpectedNil, message: errorMessage))
			let newWeatherLoadingVC = UIHostingController(rootView: newWeatherLoadingView)
			
			self.window?.rootViewController = newWeatherLoadingVC
			return
		}
        
        Task {
            let weatherDTOResult = await WeatherKitManager.getWeatherDTO(latitude: sureLatitude, longitude: sureLongitude)
            switch weatherDTOResult {
                case .success(let weatherDTO):
                    WeatherViewModel.shared = WeatherViewModel(dto: weatherDTO)
                    guard let weatherVM = WeatherViewModel.shared else { print("error"); return }
                    
                    DispatchQueue.main.async {
                        let weatherView = WeatherView(weatherVM: weatherVM)
                        let weatherViewVC = UIHostingController(rootView: weatherView)
                        self.window?.rootViewController = weatherViewVC
                        
                        // Animate change
                        guard let sureWindow = self.window else { return }
                        UIView.transition(with: sureWindow, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        let newWeatherLoadingView = WeatherLoadingView(error: error)
                        let newWeatherLoadingVC = UIHostingController(rootView: newWeatherLoadingView)
                        
                        self.window?.rootViewController = newWeatherLoadingVC
                    }
            }
        }
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
		
		/// Fetch new data if it's been greater than 1 minute.
		if let sureLastFetchedTime = WeatherViewModel.shared?.lastFetchedTime,
			Date() > Date(timeInterval: (60 * 1), since: sureLastFetchedTime) {
            Task {
                await WeatherViewModel.shared?.updateWeatherData()
            }
		}
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

