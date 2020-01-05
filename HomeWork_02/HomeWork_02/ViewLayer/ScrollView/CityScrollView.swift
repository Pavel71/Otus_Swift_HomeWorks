//
//  CityScrollView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 19.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI

struct CityScrollView: View {

  
  
  @EnvironmentObject var weatherVMWithPublisher : WeatherVMWithPublishers
  
  
  var body: some View {
    
    GeometryReader { geo in
   
      
      RefreshableHorizontalScrollView(width: 90, refreshing: self.$weatherVMWithPublisher.loadingNewCityies) {
        
        HStack {
          ForEach(self.weatherVMWithPublisher.favoritsCity.indexed(),id: \.1.self) {idx,city in
            
            Group {
              CityCell(
                height        : geo.size.width / 4,
                width         : geo.size.width / 4,
                idxSelectCell : self.$weatherVMWithPublisher.selectedCity,
                idxCell       : idx,
                cityName      : city)
              
            }.frame(width: geo.size.width / 3 + 20)
            
            
          }
          
        }
        
      }
      
      
      // Geo Reader
    }
    
  }
}


// Можно сюда всегда добавлять еще 1 ячейку которая будет содержать активити индикатор и как только мы додйем до конца показать эту ячейку

struct CityCell: View {
  
  var height     : CGFloat
  var width      : CGFloat
  
  
  @Binding var idxSelectCell : Int
  var idxCell                : Int
  
  var cityName               : String
  
  var body: some View {
    
    
    
    Image(cityName)
      .resizable()
      .padding(10)
      .frame(width: width,height:   height)
      .onTapGesture {self.idxSelectCell = self.idxCell}
      .background(CityBorder(show: idxCell == idxSelectCell))
    
  }
}

struct CityBorder: View {
  let show: Bool
  
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .stroke(lineWidth: 3.0)
      .foregroundColor(show ? Color.white : Color.clear)
      .opacity(show ? 1.0 : 0.0)
      .animation(.easeInOut(duration: 0.2))
    
  }
}

//struct CityScrollView_Previews: PreviewProvider {
//  static var previews: some View {
//    CityScrollView(selectedCell: 0)
//  }
//}
