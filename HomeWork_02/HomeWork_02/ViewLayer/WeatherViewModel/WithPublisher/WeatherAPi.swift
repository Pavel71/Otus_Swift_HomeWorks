//
//  WeatherAPi.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 30.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import Combine
import SwiftUI



final class WeatherAPi {
  
  public static let shared = WeatherAPi()
  
  private var subscriptions = Set<AnyCancellable>()
  private let urlSession = URLSession.shared
  
  private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
  }()
  
  
  
  // Возвращаем паблишер с загруженными данными
  
  func fecthCityWeather(city: String) -> Future <WeatherModel, WeatherAPIError> {
    
    
    return Future<WeatherModel, WeatherAPIError> { [unowned self] promise in
      
      // Получили url Если сформировали не правельно то возвращаем ошибку
      
      guard let url = WeatherUrlCreater.getWeatherRequestUrl(city: city) else {
        return promise(.failure(WeatherAPIError.urlError(.init(.unsupportedURL))))
      }
      
      // URL есть отправляем запрос на API
      
      // TRy Map преобразуем получает данные от паблишера и обрабатывает посылает их другому паблишеру если все норм
      
      self.urlSession.dataTaskPublisher(for: url)
        .tryMap { (data,response) -> Data in
          guard let httpResponse = response as? HTTPURLResponse, 200...299 ~=  httpResponse.statusCode else {
            
            throw WeatherAPIError.responseError(
              (response as? HTTPURLResponse)?.statusCode ?? 500
            )
          }
          // 1ый паблишер 
          return data
          
      }.decode(type: CityWeatherModel.self, decoder: self.jsonDecoder) // 2ой publisher
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: {  complition in
          
          // Собираем все ошибки на предыдущих этапах
          
          if case let .failure(error) = complition {
            switch error {
            case let urlError as URLError:
              promise(.failure(.urlError(urlError)))
            case let decodingError as DecodingError:
              promise(.failure(.decodingError(decodingError)))
            case let apiError as WeatherAPIError:
              promise(.failure(apiError))
            default:
              promise(.failure(.genericError))
            }
          }
        }) { (cityWeatherModel) in
          // Это нужно вынести в парсинг decode - но пока оставлю так
          let id           = cityWeatherModel.weather[0].id
          let name         = cityWeatherModel.name
          let temperature  = cityWeatherModel.main.temp
          
          let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: Int(temperature))
          
          promise(.success(weatherModel))
          
      }.store(in: &self.subscriptions)
      
      
    }
    
  }
  
}
