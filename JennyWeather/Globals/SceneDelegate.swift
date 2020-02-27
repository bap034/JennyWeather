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
		let higbyLatitude = 37.8267
		let higbyLongitude = -122.28
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: higbyLatitude, longitude: higbyLongitude, success: { (json) in
			guard let weatherVM = try? WeatherViewModel(json: json) else { print("error"); return }

			DispatchQueue.main.async {
				let weatherView = WeatherView(weatherVM: weatherVM)
				let weatherViewVC = UIHostingController(rootView: weatherView)
				let nc = UINavigationController(rootViewController: weatherViewVC)
				nc.modalTransitionStyle = .crossDissolve
				nc.modalPresentationStyle = .fullScreen
				
				guard let sureWindowVC = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController else { print("no window VC"); return }
				
				sureWindowVC.present(nc, animated: true, completion: nil)
			}
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
		})
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

