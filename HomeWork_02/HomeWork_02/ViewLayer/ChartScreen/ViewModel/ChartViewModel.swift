//
//  ChartViewModel.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 14.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUICharts

struct CityTemperatureForLast10DaysModel  {
  
  var cityName     : String
  var temperatures : [Double] = []
}

// Короче мне нужны туту будут кастомные данные! Так как натуральные требуют платную подписку! и Все получить данные передать в модель! Сделать ее 1 основную и в ней уже подмодели чтобы не было путаницы!

final class ChartViewModel: ObservableObject {
  
  // Input
  @Published private var cityName: String = "Tula"

  
  var typeChart: ChartType = .bar
  private var cancallabelSet : Set <AnyCancellable> = []
  private var weatherApi           = WeatherAPi.shared
  
  
  // Теперь каждый раз как мы изменяем cityName мы получаем новую модельку и оюбновляем View
  
  // OutPut
  @Published var chartModel: CityTemperatureForLast10DaysModel = CityTemperatureForLast10DaysModel(cityName: "TTT")
  
  init() {
    
    // Предположем здесь мы обращаемся к Апи и получаем данные по графику
    
    $cityName.map {cityName -> CityTemperatureForLast10DaysModel in
      
      // Получим 20 случайных цифр от 0 до 20
      let temperatureData:[Double] = (0...20).map {_ in Double(Int.random(in: 0...20))}

      let dummyCityFor16DaysTemperatureModel = CityTemperatureForLast10DaysModel(
        cityName: cityName,
        temperatures: temperatureData
      )

      return dummyCityFor16DaysTemperatureModel
      
      
    }
        .assign(to: \.chartModel, on: self)
        .store(in: &cancallabelSet)

    
  }
  
  func prepareData(type: ChartType, cityName: String) {
    
    self.typeChart = type
    self.cityName  = cityName

    
  }
  
  
}
