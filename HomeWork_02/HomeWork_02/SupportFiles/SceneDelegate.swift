//
//  SceneDelegate.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 16.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    
    // Service Locator
    let appStateService: AppState = AppState.shared
    ServiceLocator.shared.addService(service: appStateService)
    
    // Create the SwiftUI view that provides the window contents.
    
    let weatherVM = WeatherVMWithPublishers()
    let chartVM   = ChartViewModel()
    
    let contentView = ContentView(weatherVMWithPublisher:weatherVM).environmentObject(chartVM)
    
    // Use a UIHostingController as window root view controller.
    if let windowScene = scene as? UIWindowScene {

      
      
      appStateService.mainWindow = UIWindow(windowScene: windowScene)
      appStateService.mainWindow?.rootViewController = UIHostingController(rootView: contentView)
      appStateService.mainWindow!.makeKeyAndVisible()
      
      
      
      
      appStateService.secondWindow = UIWindow(windowScene: windowScene)

      let vc = UIHostingController(rootView: ChartView().environmentObject(chartVM))
//      vc.view.backgroundColor = .clear // Если мы хотим показать окно поверх Main

      appStateService.secondWindow?.windowLevel = UIWindow.Level.alert + 1
      appStateService.secondWindow?.rootViewController = vc
      
    }
    
    
  }
  
  
  
  
}

