//
//  ContentView.swift
//  HomeWork_01
//
//  Created by Павел Мишагин on 05.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI



struct RootView: View {
  
  @State private var selection = 0
  // При изменение этого стейта мы переходим ячейки в ListView
  @State private var indexRow: Int? 

  
  var body: some View {
    
    TabView(selection: $selection) {
      
      StartView(selection : $selection,
                indexRow  : $indexRow).tabItem {
        VStack {
          Text("Start")
          Image(systemName: "bolt")
        }
      }.tag(0)
      
      ListVIew(indexRow: $indexRow)
 
        .tabItem {
        Text("List")
        Image(systemName: "list.bullet")
      }.tag(1)
      
      ModalView().tabItem {
        Text("Modal")
        Image(systemName: "play.circle")
      }.tag(2)
      
    }
    
    
    
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
