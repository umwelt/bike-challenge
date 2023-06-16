//
//  BikeStationListView.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import SwiftUI

struct BikeStationListView: View {
	@StateObject private var viewModel = BikeStationListViewModel()
	@State private var errorMessage: String?

	struct Strings {
		static let title = "Bike Stations"
		static let errorPrefix = "Error fetching bike stations: "
	}

	var body: some View {
		VStack {
			if let errorMessage = errorMessage {
				Text(errorMessage)
					.foregroundColor(.red)
					.padding()
			} else {
				Text(Strings.title)
					.font(.title)
					.padding()

				ScrollView {
					VStack {
						ForEach(viewModel.bikeStations, id: \.id) { station in
							BikeStationRow(bikeStation: station)
								.frame(maxWidth: .infinity, alignment: .leading)
						}
					}
				}
				.overlay(
					Group {
						if viewModel.isRefreshing {
							ProgressView() // The system activity indicator
								.scaleEffect(1.5, anchor: .center)
						}
					}, alignment: .center
				)

				Spacer()
			}
		}
		.navigationTitle(Strings.title)
		.refreshable {
			await fetchBikeStations()
		}
		.task {
			await fetchBikeStations()
		}
		.padding()
	}

	private func fetchBikeStations() async {
		do {
			try await viewModel.fetchBikeStations()
		} catch {
			errorMessage = Strings.errorPrefix + error.localizedDescription
		}
	}
}
