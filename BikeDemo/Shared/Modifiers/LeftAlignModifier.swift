//
//  LeftAlignModifier.swift
//  BikeDemo
//
//  Created by Hugo Perez on 16/6/23.
//

import SwiftUI

struct LeftAlignModifier: ViewModifier {
	func body(content: Content) -> some View {
		HStack {
			content
			Spacer()
		}
	}
}
