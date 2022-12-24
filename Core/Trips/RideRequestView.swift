//
//  RideRequestView.swift
//  Uber
//
//  Created by Taha Afzal on 12/23/22.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
		VStack {
			Capsule()
				.foregroundColor(Color(.systemGray5))
				.frame(width: 48, height: 6)
			HStack {
				VStack {
					Circle()
						.fill(Color(.systemGray3))
						.frame(width: 6, height: 6)
					
					Rectangle()
						.fill(.gray)
						.frame(width: 2, height: 24)
					
					Rectangle()
						.fill(.black)
						.frame(width: 6, height: 6)
				}
				
				VStack(alignment: .leading, spacing: 24) {
					HStack {
						Text("Current location")
						
						Spacer()
						
						Text("9:41 AM")
					}
					.font(.system(size: 16))
					
					HStack {
						Text("Apple Park")
							.foregroundColor(.black)
						
						Spacer()
						
						Text("10:09 AM")
					}
					.font(.system(size: 16, weight: .semibold))
				}
				.foregroundColor(.gray)
				.padding(.leading, 8)
			}
			
			Divider()
			
			Text("OPTIONS")
				.font(.subheadline)
				.foregroundColor(.gray)
				.fontWeight(.semibold)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.top, 20)
			
			ScrollView(.horizontal) {
				HStack(spacing: 12) {
					ForEach(RideType.allCases) { rideType in
						VStack(alignment: .leading) {
							Image(rideType.imageName)
								.resizable()
								.scaledToFit()
							
							VStack(spacing: 4) {
								Text(rideType.description)
									.font(.system(size: 16, weight: .semibold))
								
								Text("$6.90")
									.font(.system(size: 16, weight: .semibold))
							}
							.padding(8)
						}
						.frame(width: 112, height: 140)
						.background(Color(.systemGroupedBackground))
						.cornerRadius(10)
					}
				}
			}
			
			Divider()
				.padding(.vertical, 8)
			
			HStack(spacing: 12) {
				Text("Visa")
					.font(.subheadline)
					.fontWeight(.semibold)
					.padding(6)
					.background(.blue)
					.cornerRadius(4)
					.foregroundColor(.white)
					.padding(.leading)
				
				Text("**** 9843")
					.fontWeight(.bold)
				
				Spacer()
				
				Image(systemName: "chevron.right")
					.imageScale(.medium)
					.padding(.trailing)
			}
			.frame(height: 50)
			.background(Color(.systemGroupedBackground))
			.cornerRadius(10)
			
			Button {
				
			} label: {
				Text("CONFIRM RIDE")
					.fontWeight(.bold)
					.frame(height: 50)
					.frame(width: UIScreen.main.bounds.width - 32, height: 50)
					.background(.blue)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
		}
		.padding([.leading, .bottom, .trailing])
		.background(.white)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
