//
//  WeatherUrlCreater.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 30.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Foundation


final class WeatherUrlCreater {
  
  
  
  static func getWeatherRequestUrl(city: String) -> URL? {
    
    let componentsUrl = self.url(city: city)
    
    return componentsUrl
  }
  
  
  static private func url(city: String) -> URL? {
    
    var components = URLComponents()
    
    components.scheme = API.scheme
    components.host   = API.host
    components.path   = API.weatherPath
    
    let params = ["q": city,"APPID": API.appiKey,"units":"metric"]
    
    
    
    components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
    
    return components.url
  }
  
}
