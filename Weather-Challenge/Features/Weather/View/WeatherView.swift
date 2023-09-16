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
            if vm.currentWeather != nil {
                BackgroundView(isNight: vm.currentWeather!.isNight)
                VStack {
                    WeatherCurrentView(weather: vm.currentWeather!)
                    WeatherForecastView(weather: vm.currentWeather!)
                    WeatherTimeView(weather: vm.currentWeather!)
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
        WeatherView(city: "Tokyo")
        WeatherView(city: "Cupertino")
    }
}

struct BackgroundView: View {
    
    let isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                .minimumScaleFactor(1)
            
            Text(weather.location.region)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            VStack(spacing: 0) {
                Image(systemName: weather.iconText)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("\(weather.tempText)°")
                    .font(.system(size: 50, weight: .medium))
                    .foregroundColor(.white)
                
                HStack {
                    MinMaxDayView(image: "arrow.up", temp: weather.forecast.maxTempDayText)
                    MinMaxDayView(image: "arrow.down", temp: weather.forecast.minTempDayText)
                }
            }
            .padding(.bottom, 50)
        }
    }
}

struct WeatherForecastView: View {
    
    let weather: weatherForecast
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(weather.forecast.forecastDay, id: \.date) { day in
                VStack {
                    Text(day.dateText.uppercased())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Image(systemName: day.iconText)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("\(day.maxDayTempText)°")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        Spacer()
    }
}

struct MinMaxDayView: View {
    
    let image: String
    let temp: Int
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: image)
            Text("\(temp)°")
        }
        .font(.system(size: 15))
        .foregroundColor(.white)
    }
}

struct WeatherTimeView: View {
    
    let weather: weatherForecast
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 25) {
                ForEach(weather.forecast.forecastDay, id: \.self) { hour in
                    ForEach(hour.hour, id: \.self) { hour in
                        VStack {
                            Text(hour.timeText)
                            Image(systemName: hour.condition.iconDayText)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("\(Int(hour.tempC.rounded()))°")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    }
                }
            }
            
        }
        .padding()
        .background(.blue.opacity(0.2))
        .cornerRadius(20)
        .padding()
    }
}
