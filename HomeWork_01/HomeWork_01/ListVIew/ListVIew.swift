//
//  ListVIew.swift
//  HomeWork_01
//
//  Created by Павел Мишагин on 05.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI

struct ListVIew: View {
  
  @Binding var indexRow: Int?
  
  
  var body: some View {
    
    NavigationView {
      List {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationLink(destination: DetailView()) {
          Text("Переход на новый экран!")
        }
        NavigationLink(
        destination: DetailView(),
        tag: 2,
        selection: self.$indexRow) {
          Text("Hello, People!")
        }
        
        Text("Hello, Tula")
      }
      .navigationBarTitle("List Screen")
    }
    
    
    
    
  }
}

//struct ListVIew_Previews: PreviewProvider {
//  

//  
//  static var previews: some View {
//    ListVIew(indexRow: $test)
//  }
//}
