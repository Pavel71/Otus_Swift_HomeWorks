//
//  ChartView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 14.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI
import SwiftUICharts

//




struct ChartView: View {
  
  @EnvironmentObject var chartVM: ChartViewModel

  var body: some View {
    
    GeometryReader { g in
      VStack {
        
        if self.chartVM.typeChart == ChartType.line {
          
          LineView(
          data:  self.chartVM.chartModel.temperatures,
          title: self.chartVM.chartModel.cityName,
          legend: "The weather for last 16 days \(self.chartVM.chartModel.cityName)",
          style: Styles.barChartStyleNeonBlueLight,
          valueSpecifier: "%.1f")
          .padding()
          
          
        } else {
          // BarView

          
           BarChartView(
            data: ChartData(points: self.chartVM.chartModel.temperatures),
            title: self.chartVM.chartModel.cityName,
            style: Styles.barChartStyleNeonBlueLight)
           .padding()
          
        }
        
        
        
        Button("toggle Back") {
          AppState.shared.toogleChartWindow()
        }
        .frame(
          height: self.chartVM.typeChart == ChartType.line ? 100 : nil,
          alignment: .bottom)
        .padding(.bottom,20)
      
        
      }
      
      .frame(
        width: self.chartVM.typeChart == ChartType.line ? g.size.width - 30 : nil,
        height: self.chartVM.typeChart == ChartType.line ? 400 : nil)
      .background(Color.orange)
      .cornerRadius(20)
      
      
    }
    
    
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ChartView().environmentObject(ChartViewModel())
  }
}
