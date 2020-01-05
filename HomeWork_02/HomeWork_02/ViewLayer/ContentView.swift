//
//  ContentView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 16.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI


struct ContentView: View {
  

  @ObservedObject var weatherVMWithPublisher : WeatherVMWithPublishers
  
  
  var body: some View {

      VStack(spacing: 10) {
        
        CityScrollView()
        .environmentObject(weatherVMWithPublisher)
        .frame(height: 150)
        
        Divider().background(Color.black)

        WeatherCell()
          .environmentObject(weatherVMWithPublisher)
          
        
        Spacer()
          
        
      }
    .background(Image("background")
    .resizable()
    .aspectRatio(contentMode: .fill)
    .edgesIgnoringSafeArea(.all))
    

  }

}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView(weatherVMWithPublisher: WeatherVMWithPublishers())
  }
}
