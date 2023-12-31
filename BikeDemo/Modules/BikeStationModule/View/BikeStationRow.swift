//
//  BikeStationRow.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import SwiftUI

struct BikeStationRow: View {
	var bikeStation: StationViewData

	struct Strings {
		static let availableBikes = "Available Bikes"
		static let emptySlots = "Empty Slots"
	}

	var body: some View {
		Button(action: {
			openMapForLocation(latitude: bikeStation.latitude, longitude: bikeStation.longitude)
		}) {
			VStack(alignment: .leading, spacing: 6) {
				Text(bikeStation.name)
					.font(.headline)
					.modifier(LeftAlignModifier())
				Text("\(Strings.availableBikes): \(bikeStation.freeBikes)")
					.font(.subheadline)
					.foregroundColor(.gray)
					.modifier(LeftAlignModifier())
				Text("\(Strings.emptySlots): \(bikeStation.emptySlots )")
					.font(.subheadline)
					.foregroundColor(.gray)
					.modifier(LeftAlignModifier())
			}
			.padding(.vertical, 8)
			.padding(.horizontal)
			.frame(maxWidth: .infinity)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.stroke(bikeStation.freeBikes > 0 ? Color.green : Color.gray, lineWidth: 2)
			)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.overlay(
				Image(systemName: "chevron.right")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 13, height: 13)
					.foregroundColor(Color.gray)
					.padding(.trailing)
				, alignment: .trailing)
		}
	}

	private func openMapForLocation(latitude: Double, longitude: Double) {
		if let url = URLHelper.mapURLForLocation(latitude: latitude, longitude: longitude) {
			UIApplication.shared.open(url)
		}
	}
}

