//
//  LocationSearchResultCell.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct LocationSearchResultCell: View {
	var title: String
	var subtitle: String
	
    var body: some View {
		HStack {
			Image(systemName: "mappin.circle.fill")
				.resizable()
				.frame(width: 40, height: 40)
				.foregroundColor(.blue)
				.accentColor(.white)
			
			VStack(alignment: .leading, spacing: 5) {
				Text(title)
					.font(.body)
					.fontWeight(.bold)
				
				Text(subtitle)
					.font(.system(size: 15))
					.foregroundColor(.gray)
				
				Divider()
			}
			.padding(.leading, 8)
		}
		.padding(.all, 5)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
		LocationSearchResultCell(title: "Apple Park", subtitle: "One Apple Park Way, California")
    }
}
