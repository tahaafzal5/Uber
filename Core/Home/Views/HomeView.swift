//
//  HomeView.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        MapViewRepresentable()
			.ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
