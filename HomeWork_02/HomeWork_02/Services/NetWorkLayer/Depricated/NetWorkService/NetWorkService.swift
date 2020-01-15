//
//  NetWorkService.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 16.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Foundation


// Класс отвечает за формирование запроса и отправку запроса на АПИ + Получение данных и передачу их DataFetcher





class NetWorkService {
  
  func request(city: String,completion: @escaping (Data?, Error?) -> Void) {
    
    let url = getWeatherRequestUrl(city: city)
        

    let request = URLRequest(url: url)
    
    let task = createDataTask(from: request, completion: completion)
    task.resume()

  }
 
  
}

// MARK: Get Task
extension NetWorkService {
  
  // Task
  private func createDataTask(from request: URLRequest,completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    
    return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      DispatchQueue.main.async {
        completion(data, error)
      }
    })
  }
}

// MARK: Get Current APi Requests
extension NetWorkService {
  
  func getWeatherRequestUrl(city: String) -> URL {
    
    let componentsUrl = self.url(city: city)
    
    return componentsUrl
  }
  
  
  private func url(city: String) -> URL {
    
    var components = URLComponents()
    
    components.scheme = API.scheme
    components.host   = API.host
    components.path   = API.weatherPathNow
    
    let params = ["q": city,"APPID": API.appiKey,"units":"metric"]
    
    
    
    components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
    
    return components.url!
  }
  
}
