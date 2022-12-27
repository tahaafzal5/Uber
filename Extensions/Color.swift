//
//  Color.swift
//  Uber
//
//  Created by Taha Afzal on 12/27/22.
//

import Foundation
import SwiftUI

extension Color {
	static let theme = ColorTheme()
}

struct ColorTheme {
	let backgroundColor = Color("BackgroundColor")
	let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
	let primaryTextColor = Color("PrimaryTextColor")
}
