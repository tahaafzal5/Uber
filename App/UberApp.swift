//
//  UberApp.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI

@main
struct UberApp: App {
	@StateObject var locationSearchViewModel = LocationSearchViewModel()
	
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environmentObject(locationSearchViewModel)
        }
    }
}
