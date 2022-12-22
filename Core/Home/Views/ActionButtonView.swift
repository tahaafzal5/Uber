//
//  ActionButtonView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct ActionButtonView: View {
    var body: some View {
		Button {
			
		} label: {
			Image(systemName: "line.3.horizontal")
				.foregroundColor(.black)
				.font(.title2)
				.padding()
				.background(.white)
				.clipShape(Circle())
				.shadow(radius: 5)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ActionButtonView()
    }
}
