//
//  WeatherUrlCreater.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 30.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Foundation


struct API {
  
  static let scheme                = "https"
  static let host                  = "api.openweathermap.org"
  static let weatherPathNow        = "/data/2.5/weather"
  static let weatherPathLast16Days = "/data/2.5/forecast/daily"
  
  static let appiKey               = "1ff8ab446fb54537ac50354a4016439c"
}


final class WeatherUrlCreater {
  
  
  
  // For Temperature Last 16 dayse
  
  
  static func getWeatherForCityLast16Days(city: String) -> URL? {
    let componentsUrl = self.urlLast16Days(city: city)
    print("for Last 16 Days Url",componentsUrl)
    return componentsUrl
  }
  
  
  static private func urlLast16Days(city: String) -> URL? {
    
    var components = URLComponents()
    
    components.scheme = API.scheme
    components.host   = API.host
    components.path   = API.weatherPathLast16Days
    
    let params = ["q": city,"APPID": API.appiKey,"units":"metric","cnt": "15"]

    components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
    
    return components.url
  }
  
  
  
  // For City Weather Now Request
  
  static func getWeatherRequestUrlCityNow(city: String) -> URL? {
    
    let componentsUrl = self.url(city: city)
    
    return componentsUrl
  }
  
  
  static private func url(city: String) -> URL? {
    
    var components = URLComponents()
    
    components.scheme = API.scheme
    components.host   = API.host
    components.path   = API.weatherPathNow
    
    let params = ["q": city,"APPID": API.appiKey,"units":"metric"]
    
    
    
    components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
    
    return components.url
  }
  
}
