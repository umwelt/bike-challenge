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
		ScrollView {
			VStack {
				ForEach(viewModel.bikeStations, id: \.id) { station in
					BikeStationRow(bikeStation: station)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
			}
			.padding()
			.overlay(
				Group {
					if viewModel.isRefreshing {
						ProgressView() // The system activity indicator
							.scaleEffect(1.5, anchor: .center)
					}
				}, alignment: .center
			)
		}
		.navigationTitle(Strings.title)
		.refreshable {
			Task {
				await fetchBikeStations()
			}
		}
		.task {
			await fetchBikeStations()
		}
	}

	private func fetchBikeStations() async {
		await viewModel.fetchBikeStations()
	}
}
