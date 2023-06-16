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
		VStack(alignment: .leading, spacing: 4) {
			Text(bikeStation.name)
				.font(.headline)
			Text("\(Strings.availableBikes): \(bikeStation.freeBikes)")
			Text("\(Strings.emptySlots): \(bikeStation.emptySlots )")
				.font(.subheadline)
				.foregroundColor(.gray)
		}
		.padding(.vertical, 8)
		.onTapGesture {
			openMapForLocation(latitude: bikeStation.latitude, longitude: bikeStation.longitude)
		}
	}

	private func openMapForLocation(latitude: Double, longitude: Double) {
		if let url = URLHelper.mapURLForLocation(latitude: latitude, longitude: longitude) {
			UIApplication.shared.open(url)
		}
	}
}

