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
  
  @Published var selectedCity        : Int = 0
  var cityWeatherModel               : WeatherModel = WeatherModel(conditionId: 800, cityName: "Ошибка API", temperature: 0)
  
  var weatherApi                      = WeatherAPi.shared
  private var cancellableSet         : Set <AnyCancellable> = []
  
  
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
      
      
      guard let randomCity = self.allCity.randomElement() else {return}
      
      if self.favoritsCity.contains(randomCity) == false {
        self.favoritsCity.append(randomCity)
      }

    }
  }
  
  deinit {
    for cancel in cancellableSet {
      cancel.cancel()
    }
  }
  
  
  
}
