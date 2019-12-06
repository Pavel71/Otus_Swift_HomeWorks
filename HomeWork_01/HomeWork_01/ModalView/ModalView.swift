//
//  ModalView.swift
//  HomeWork_01
//
//  Created by Павел Мишагин on 05.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import SwiftUI
import BetterSheet

struct ModalView: View {
  
  @State var showModal: Bool = false
  
  
    var body: some View {
      
      Button(action: {
        print("Some Action")
        self.showModal = true
      }) {
        Image(systemName:"play.circle")
        .resizable()
        .frame(width: 150, height: 150)
        
        // Он просто не работае в Canvase
      }.betterSheet(isPresented: $showModal,
                    onDismiss  : {
                      print("Dismiss Modal")
                      }
                   ) {
        Text("Some Modal")
      }
      
      
    }
}



struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
