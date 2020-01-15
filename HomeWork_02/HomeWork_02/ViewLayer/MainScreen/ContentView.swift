//
//  ContentView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 16.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI
import Combine

enum ChartType: String {
  case line = "line"
  case bar  = "bar"
}


struct ContentView: View {
  
  
  @ObservedObject var weatherVMWithPublisher : WeatherVMWithPublishers
  @State var showChartsButton = false
  @EnvironmentObject var  chartVM             : ChartViewModel
  
  
  var body: some View {
    
    VStack(spacing: 10) {
      
      CityScrollView()
        .environmentObject(weatherVMWithPublisher)
        .frame(height: 150)
      
      Divider().background(Color.black)
      
      WeatherCell()
        .environmentObject(weatherVMWithPublisher)
      
      
      Spacer()
      // Chart Buttons
      ZStack {
        Group {
          
          Image(systemName: "chart.bar")
            .resizable()
            .frame(width: 70,height: 70)
            .offset(
              x: self.showChartsButton ? -70 : 0,
              y: self.showChartsButton ? -110 : 0
          )
            .opacity(self.showChartsButton ? 1 : 0)
            .onTapGesture {
              
              self.showChartsButton.toggle()
              
              
              AppState.shared.toogleChartWindow()
              self.chartVM.prepareData(type: .bar, cityName: self.weatherVMWithPublisher.selectedCityName)
              
          }
          
          
          Image("line")
            .renderingMode(.template)
            .resizable()
            .frame(width: 70,height: 70)
            .offset(
              x: self.showChartsButton ? 70 : 0,
              y: self.showChartsButton ? -110 : 0
          )
            .opacity(self.showChartsButton ? 1 : 0)
            .onTapGesture {
              
              self.showChartsButton.toggle()
              
              
              AppState.shared.toogleChartWindow()
              self.chartVM.prepareData(type: .line, cityName: self.weatherVMWithPublisher.selectedCityName)
              
          }
          
          Button(action: {
            self.showChartsButton.toggle()
          }, label: {
            
            Image(systemName: showChartsButton ? "xmark.circle" : "chart.pie")
              .resizable()
              .frame(width: 70,height: 70)
              .background(Circle().fill(Color.purple).shadow(radius: 8, x: 4, y: 4))
              .offset(y: self.showChartsButton ? -20 : 0)
            
          })
        }
        .foregroundColor(.white)
        .animation(.default)
        .padding()
      }
      
      // Chart Buttons
      
    }
    .background(Image("background")
    .resizable()
    .aspectRatio(contentMode: .fill)
    .edgesIgnoringSafeArea(.all))
    
    
  }
  
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView(weatherVMWithPublisher: WeatherVMWithPublishers()).environmentObject(ChartViewModel())
  }
}
