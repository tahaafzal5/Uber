//
//  LocationSearchView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct LocationSearchView: View {
	
	@State private var startLocation = ""
	@State private var destinationLocation = ""
	
	var body: some View {
		VStack {
			
			// Search bars
			HStack {
				VStack {
					Circle()
						.fill(Color(.systemGray3))
						.frame(width: 6)
					
					Rectangle()
						.fill(.gray)
						.frame(width: 2, height: 24)
					
					Rectangle()
						.fill(.black)
						.frame(width: 6, height: 6)
				}
				
				VStack {
					TextField("  Current location", text: $startLocation)
						.frame(height: 32)
						.background(Color(
							.systemGroupedBackground
						))
					
					TextField("  Where to?", text: $destinationLocation)
						.frame(height: 32)
						.background(Color(
							.systemGray4
						))
				}
			}
			.padding(.top, 65)
			
			Divider()
				.padding(.vertical)
			
			// List
			ScrollView {
				VStack(alignment: .leading) {
					ForEach(0 ..< 20, id: \.self) {_ in
						LocationSearchResultCell()
					}
				}
			}
		}
		.padding(.horizontal)
		.background(.white)
	}
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
