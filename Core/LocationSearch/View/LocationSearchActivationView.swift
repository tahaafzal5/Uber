//
//  LocationSearchActivationView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
		HStack {
			Rectangle()
				.fill(.black)
				.frame(width: 8, height: 8)
				.padding(.leading)
			
			Text("Where to?")
				.foregroundColor(Color(.darkGray))
			
			Spacer()
		}
		.frame(width: UIScreen.main.bounds.width - 64, height: 50)
		.background(
			Rectangle()
				.fill(.white)
				.shadow(radius: 5 )
		)
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
