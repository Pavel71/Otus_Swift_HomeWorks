//
//  WeatherViewModel.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 20.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI



// Сделаю симуляцию пейджинга для CollectionView
// Остальное же при нажатии на ячейку города запущу подгрузку данных с activityIndicator акщь UIKit


// Сейчас задача простоая
// Нужно добавлять по 1 городу из списка All city в favoritsCity
// после того как мы долистали до последнего города


class WeatherViewModel: ObservableObject {
  
  var netWorkDataFetcher: NetworkDataFetcher
  
  var allCity      = ["Barcelona","St.Peterburg","Amsterdam","New Yourk","Los Angeles"]
  var favoritsCity = ["Tula","London","Moscow","Paris","Berlin"]
  
  @Published var isactivateAnimation : Bool  = false
  @Published var isLoaded            : Bool  = false
  @Published var selectedCity        : Int   = 0 {
    didSet {
      loadCityData()
    }
  }

  
  var cityWeatherModel  : WeatherModel
  
  
  var countLoaded = 0
  
  init() {
    self.netWorkDataFetcher = NetworkDataFetcher()
    self.cityWeatherModel   = WeatherModel(conditionId: 800, cityName: "", temperature: 0)
    
    // ТОесть моя задача после поступления инфомрация на выбор города запустить загрузку данных получить паблишер и прокинуть его данные подписчику в виде модели! когда модель обновится UI тоже обновится
    
  }
  
  
  func loadCityData() {
    
    // Здесь нужно дать время орендарить Экран на false state
    self.isactivateAnimation = false
    self.isLoaded            = false
    
    let cityName = self.favoritsCity[self.selectedCity]
    
    self.netWorkDataFetcher.getCityData(city:cityName) { result in
      
      switch result {
        
      case .success(let weatherModel):
        
        self.cityWeatherModel  = weatherModel
        self.isLoaded = true
        
        // Даем время обновится ui перед анимацией
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(60)) {
          
          self.isactivateAnimation = true
        }
        
        
      case .failure(let error):
        print("Error Connect:",error)
        
      }
      
    }
    
    
    
    
  }
  
  
  // Тестуирую асинхронную загрузку нескольких городов
  //  func loadData() {
  //
  //    let dispatchGroup = DispatchGroup()
  //
  //    var tempArray: [WeatherModel] = []
  //
  //    for city in favoritsCity {
  //      dispatchGroup.enter()
  //
  //      netWorkDataFetcher.getCityData(city: city) { result in
  //        switch result {
  //
  //        case .success(let weatherModel):
  //
  //          tempArray.append(weatherModel)
  //          dispatchGroup.leave()
  //
  //        case .failure(let error):
  //          print("Error Connect:",error)
  //        }
  //      }
  //    }
  //
  //    // Делаю группу чтобы добавить 1 раз и не обнавлять вью каждый раз как пройдет Аппенд модели
  //    dispatchGroup.notify(queue: .main) {
  //      print("Скачал все данные")
  //      print(tempArray)
  //      self.cityWeatherModels.append(contentsOf: tempArray)
  //      self.isLoaded.toggle()
  //    }
  //
  //
  //  }
  
  
  
}
