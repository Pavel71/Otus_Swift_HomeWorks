//
//  WeatherVMWithPublishers.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 30.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Combine
import SwiftUI



final class WeatherVMWithPublishers: ObservableObject {
  
  @Published var isactivateAnimation : Bool  = false
  @Published var isLoaded            : Bool  = false
  
  @Published var selectedCity        : Int   = 0
  
  var selectedCityName : String {
    print("Computed Favorit CityName , \(favoritsCity[selectedCity])")
    return favoritsCity[selectedCity]
  }
  
  var cityWeatherModel               : WeatherModel = WeatherModel(conditionId: 800, cityName: "Ошибка API", temperature: 0)
  
  var weatherApi                      = WeatherAPi.shared
  private var cancellableSet         : Set <AnyCancellable> = []
  
  
  
  // ScrollView
  // ВОзможно стоит переписать свою ViewModel
  
  var allCity    = ["Barcelona","Dubai","New York","Los Angeles"]
  
  @Published var loadingNewCityies: Bool = false {
    didSet {
      if oldValue == false && loadingNewCityies == true {
        self.addNewCities()
      }
    }
  }
  
  
  @Published var favoritsCity = ["Tula","London","Moscow","Paris","Berlin"]
  
  init() {
    
    // ScrollView Selected New City
    
    $selectedCity.flatMap { (selectedIndex) -> AnyPublisher<WeatherModel, Never> in
      
      self.isactivateAnimation = false
      self.isLoaded            = false
      
      return self.weatherApi.fecthCityWeather(city: self.favoritsCity[selectedIndex])
        .replaceError(with: WeatherModel(conditionId: 800, cityName: "Ошибка API", temperature: 0))
        .eraseToAnyPublisher()
      
    }.sink(receiveValue: { (weatherModel) in
      self.cityWeatherModel  = weatherModel
      self.isLoaded = true
      
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(60)) {
        self.isactivateAnimation = true
      }
      
    })
      .store(in: &cancellableSet)
    
    
  }
  
  // Метод имитирует добавление новых городов в нашу коллекцию!
  
  func addNewCities() {

    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      
      
      self.loadingNewCityies = false
      
      guard let lastCity = self.allCity.last else {return}
      self.allCity = self.allCity.dropLast()
      self.favoritsCity.append(lastCity)
    }
  }
  
  
  
//  func prepareDataFrom16DaysTemperatureToChartView(typeChart: ChartType) {
//
//    self.chartVM.prepareData(type: typeChart, cityName: favoritsCity[selectedCity])
////    self.chartVM.typeChart = typeChart
////    self.chartVM.cityName  = favoritsCity[selectedCity]
//
//  }
  
  
  
  
  
  
  
  
  deinit {
    for cancel in cancellableSet {
      cancel.cancel()
    }
  }
  
  
  
}
