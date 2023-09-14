//
//  WeatherViewModel.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published private(set) var currentWeather: weatherForecast?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    @MainActor
    func fetchCurrentWeather(city: String) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            self.currentWeather = try await NetworkingManager.shared.request(.weather(city: city))
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}

extension WeatherViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
