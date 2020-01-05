//
//  NetWorkService.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 16.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Foundation


// Класс отвечает за формирование запроса и отправку запроса на АПИ + Получение данных и передачу их DataFetcher



struct API {
  
  static let scheme      = "https"
  static let host        = "api.openweathermap.org"
  static let weatherPath = "/data/2.5/weather"
  
  static let appiKey     = "1ff8ab446fb54537ac50354a4016439c"
}

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
    components.path   = API.weatherPath
    
    let params = ["q": city,"APPID": API.appiKey,"units":"metric"]
    
    
    
    components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
    
    return components.url!
  }
  
}
