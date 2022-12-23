//
//  ActionButtonView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct ActionButtonView: View {
	@Binding var isBackArrow: Bool
	
    var body: some View {
		Button {
			withAnimation(.spring()) {
				isBackArrow.toggle()
			}
		} label: {
			Image(systemName: isBackArrow ? "arrow.left" : "line.3.horizontal")
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
		ActionButtonView(isBackArrow: .constant(false))
    }
}
