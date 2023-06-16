# BikeMap

BikeMap is a SwiftUI-based demo project that displays bike station data. It fetches information about bike stations in Vienna from the citybik.es API and presents it in an easy-to-understand format.

## Features

- **View Bike Stations**: The application fetches and displays a list of bike stations along with their associated data such as the station's name, number of free bikes, number of empty slots, latitude and longitude.
- **Asynchronous Programming**: The application makes use of Swift 5.5's new concurrency model for fetching and displaying data from the API.
- **Error Handling**: The application is designed to handle different types of errors that could occur during the process of fetching and displaying data, such as network errors, decoding errors, and invalid URLs.
- **Responsive UI**: The application updates its UI in response to the fetched data. For instance, an activity indicator is shown while data is being fetched, and any errors that occur are displayed to the user.

## Implementation

The app is structured following the MVVM (Model-View-ViewModel) design pattern.

- **Model**: Defines the data structure for the bike stations. The model classes include `Station`, `NetworkResponse`, and `StationViewData`.
- **View**: Defines the SwiftUI views that present the bike station data. The main view is `BikeStationListView`, which displays a list of bike stations. Each bike station is represented by a `BikeStationRow`.
- **ViewModel**: Acts as an intermediary between the Model and View. The `BikeStationListViewModel` fetches bike station data from the API and stores it in its `bikeStations` property, which is observed by the View.

The network calls are handled by the `APIClient`, which conforms to the `APIClientProtocol`. This makes it easier to switch to a different API client in the future if needed. The `APIClient` uses Swift's new concurrency features to fetch data from the API asynchronously.

The `BikeStationDatasource` class is responsible for fetching bike station data from the API using the `APIClient`.


