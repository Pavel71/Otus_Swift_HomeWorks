//
//  NetworkDataFetcher.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 17.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import UIKit

// Класс отвечает за преобразование данных из Json  в модельку

class NetworkDataFetcher {
  
  var netWorkService: NetWorkService
  
  init() {
    self.netWorkService = NetWorkService()
  }
  
  func getCityData(city: String, completionHandler: @escaping (Result<WeatherModel, Error>) -> Void) {
    
    
    netWorkService.request(city: city, completion: { (data, error) in
      if let error = error {
        completionHandler(.failure(error))
      }
      
      
      let decode = self.decodeJSON(type: CityWeatherModel.self, from: data)
      
      let id           = decode?.weather[0].id ?? 800
      let name         = decode?.name ?? ""
      let temperature  = decode?.main.temp ?? 0
      
      let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: Int(temperature))
      completionHandler(.success(weatherModel))
    })
  }
  
  
  private func decodeJSON<T: Decodable>(type: T.Type,from: Data?) -> T? {
     
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     guard let data = from,  let response = try? decoder.decode(type, from: data) else {return nil}
     
     return response
   }
  
}
