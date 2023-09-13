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
            
            if vm.currentWeather != nil {
                WeatherCurrentView(weather: vm.currentWeather!)
            }
        }
        .task {
            await vm.fetchCurrentWeather(city: city)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: "lyon")
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherCurrentView: View {
    
    let weather: Current
    
    var body: some View {
        VStack {
            Text("\(weather.location.name), \(weather.location.country)")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
                .padding(.top)
            
            Text(weather.location.region)
                .font(.system(size: 15, weight: .medium))
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
            Spacer()
        }
    }
}
