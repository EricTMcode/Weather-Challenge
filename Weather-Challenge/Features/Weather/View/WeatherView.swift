//
//  WeatherView.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var vm = WeatherViewModel()
    let lat: Double
    let lon: Double
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            if vm.currentWeather != nil {
                VStack {
                    Text("\(vm.currentWeather!.name), \(vm.currentWeather!.sys.country)")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.white)
                        .padding()
                    
                    VStack(spacing: 10) {
                        Image(systemName: vm.currentWeather!.iconImage)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                        
                        Text("\(vm.currentWeather!.main.tempText)°c")
                            .font(.system(size: 50, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 40)
                    Spacer()
                }
            }
        }
        .task {
            await vm.fetchCurrentWeather(lat: lat, lon: lon)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(lat: 37.32, lon: -122.03)
        WeatherView(lat: 45.76, lon: 4.81)
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
