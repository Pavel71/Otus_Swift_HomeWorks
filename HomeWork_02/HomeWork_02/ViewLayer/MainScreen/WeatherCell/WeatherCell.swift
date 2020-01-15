//
//  WeatherCell.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 17.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI


// View - отображает ячейку с данными по погоде для конкретного города


// Сначала мне нужно обновить данные потом сделать анимацию!

struct WeatherCell: View {
  
  //  var cityWeather: WeatherModel
  
  
  @EnvironmentObject var weatherVMWithPublisher : WeatherVMWithPublishers
  

  var body: some View {
    
    GeometryReader { g in
      
      HStack {
        
        Spacer()
        
        
        VStack(alignment: .trailing,spacing: 20){
 
          Image(systemName: self.weatherVMWithPublisher.cityWeatherModel.conditionName)
            .resizable()
            .frame(width: 150,height:150)

          Text(self.weatherVMWithPublisher.cityWeatherModel.cityName)
            .font(.system(size: 80))

          Text("\(self.weatherVMWithPublisher.cityWeatherModel.temperature) ℃")
            .font(.system(size: 40))

        }
        .foregroundColor(.secondary)
        
        
      }
      .padding(.trailing,20)
      .padding(.top,20)
      .opacity(self.weatherVMWithPublisher.isactivateAnimation ? 1.0 : 0)
      .scaleEffect(self.weatherVMWithPublisher.isLoaded ? 1: 0.25)
      .scaleEffect(self.weatherVMWithPublisher.isactivateAnimation ? 1: 0.25)
      .animation(self.weatherVMWithPublisher.isactivateAnimation ? .spring() : .none)
      
      
      ActivityIndicatorView()
        .frame(width: 100, height: 100)
        .foregroundColor(.white)
        .position(x: g.size.width / 2, y: g.size.height / 2)
        .opacity(self.weatherVMWithPublisher.isLoaded ? 0 : 1.0)
        .animation(.default)

      
      
      
      // BOdy + Geometry .animation(.default)
    }
    
    
  }
}

//struct WeatherCell_Previews: PreviewProvider {
//  static var previews: some View {
//
//
//
////    WeatherCell(cityWeather: WeatherModel(
////      conditionId: 800,
////      cityName: "London ",
////      temperature: 8))
////  }
//}
