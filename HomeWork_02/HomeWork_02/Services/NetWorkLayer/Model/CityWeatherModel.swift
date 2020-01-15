//
//  CityWeatherModel.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 17.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Foundation



struct CityWeatherModel: Decodable {
  
  var weather : [Weather]
  var main    : Main
  var wind    : Wind
  var clouds  : Clouds
  var name    : String
}

struct Weather: Decodable {
  
  var id          : Int
  var main        : String
  var description : String
  var icon        : String
}

struct Main: Decodable {
  
    var temp       : Double
    var feelsLike  : Double
    var humidity   : Double
  
}

struct Wind: Decodable {
  var speed : Double
  var deg   : Double
}

struct Clouds: Decodable {
  var all : Double
}

