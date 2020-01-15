//
//  ChartButtonView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 13.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI

struct ChartButtonView: View {
  
  
  @State var showChartsButton = false
  
  var body: some View {
    
    ZStack(alignment: .bottom) {
      Color.green

        Group {
          
          Image(systemName: "chart.bar")
            .resizable()
            .frame(width: 70,height: 70)
            .offset(
              x: self.showChartsButton ? -70 : 0,
              y: self.showChartsButton ? -110 : 0
          )
            .opacity(self.showChartsButton ? 1 : 0)
            .onTapGesture {
              print("Bar")
          }

          
          Image("line")
            .renderingMode(.template)
            .resizable()
            .frame(width: 70,height: 70)
            .offset(
              x: self.showChartsButton ? 70 : 0,
              y: self.showChartsButton ? -110 : 0
          )
            .opacity(self.showChartsButton ? 1 : 0)
          .onTapGesture {
              print("Line")
          }
          
          Button(action: {
            self.showChartsButton.toggle()
          }, label: {
            
            Image(systemName: showChartsButton ? "xmark.circle" : "chart.pie")
              .resizable()
              .frame(width: 70,height: 70)
              .background(Circle().fill(Color.purple).shadow(radius: 8, x: 4, y: 4))
              .offset(y: self.showChartsButton ? -20 : 0)
            
          })
        }
          .foregroundColor(.white)
          .animation(.default)
          .padding()

    }.edgesIgnoringSafeArea(.all)
    
  }
}

//struct ChartsButtonImageModifire: ViewModifier {
//
//
//
//  func body(content:Content) -> some View {
//    return content
//    .resizable()
//    .frame(width: 70,height: 70)
//    .foregroundColor(Color.white)
//  }
//}



//struct MyButtonStyle: ButtonStyle {
//    var imageName: String
//
//    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
//
//      return Image(systemName: imageName)
//      .resizable()
//      .frame(width: 70,height: 70)
//      .foregroundColor(Color.white)
//    }
//}
//
//
//struct ChartButton: View {
//
//    let imageName: String
//    var font: Font = .title
//    var textColor: Color = .white
//    let action: () -> ()
//
//    var body: some View {
//        Button(action: {
//            self.action()
//        }, label: {
//             Image(systemName: imageName)
//               .resizable()
//               .frame(width: 70,height: 70)
//               .foregroundColor(Color.white)
//
//        })
//    }
//}




struct ChartButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ChartButtonView()
  }
}
