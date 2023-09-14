//
//  WeatherView.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var vm = WeatherViewModel()
    let city: String
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                if vm.currentWeather != nil {
                    WeatherCurrentView(weather: vm.currentWeather!)
                    WeatherForecastView(weather: vm.currentWeather!)
                }
            }
        }
        .task {
            await vm.fetchCurrentWeather(city: city)
        }
        .overlay {
            if vm.viewState == .loading {
                ProgressView()
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {
                Task {
                    await vm.fetchCurrentWeather(city: city)
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: "Lyon")
        WeatherView(city: "Madrid")
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherCurrentView: View {
    
    let weather: weatherForecast
    
    var body: some View {
        VStack {
            Text("\(weather.location.name), \(weather.location.country)")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
                .padding([.top, .leading, .trailing])
                .lineLimit(1)
            
            Text(weather.location.region)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 40)
            
            VStack(spacing: 30) {
                Image(systemName: weather.current.condition.iconText)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("\(weather.current.tempC)°c")
                    .font(.system(size: 50, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 40)
        }
    }
}

struct WeatherForecastView: View {
    
    let weather: weatherForecast
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach((weather.forecast.forecastDay), id: \.self) { day in
                VStack {
                    Text(day.dateText.uppercased())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Image(systemName: day.day.condition.iconText)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("\(day.day.tempText)°")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        Spacer()
    }
}
