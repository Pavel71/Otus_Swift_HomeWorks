//
//  AppState.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 14.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import UIKit




final class AppState {
  
  static var shared = AppState()
  
  var mainWindow   : UIWindow?
  var secondWindow : UIWindow?
  
  // Мне нужно передать свойства из одного Window в другой
  
  // 1. Я подгружаю новый window и показываю АктивитиИндикатор
  // 2. Паралельно я загружаю данные для графика
  // 3. Когда загрузка закончилась я отображаю данные
  // 4. Нужна кнопка возврата назад
  
  private init () {}
  
  
  
  func toogleChartWindow() {
    
    
    if let window2 = secondWindow {
      
      if window2.isKeyWindow {
        mainWindow?.makeKeyAndVisible()
        window2.isHidden = true
      } else {
        window2.makeKeyAndVisible()
        window2.isHidden = false
        
      }
    }
  }
  
}
