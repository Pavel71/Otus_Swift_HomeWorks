//
//  StartView.swift
//  HomeWork_01
//
//  Created by Павел Мишагин on 05.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI

struct StartView: View {
  
  @Binding var selection : Int
  @Binding var indexRow  : Int?
  
    var body: some View {
      
      Button(action: {
        print("Нужен переход ко второму экрану  xthtp таб")
        self.selection = 1
        self.indexRow  = 2
      }) {
        Image(systemName: "list.bullet")
        .resizable()
        .frame(width: 100, height: 100)
      }
     
        
      
      
    }
}

//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartView()
//    }
//}
