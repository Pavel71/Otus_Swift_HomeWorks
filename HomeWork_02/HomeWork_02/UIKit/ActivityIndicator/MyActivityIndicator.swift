//
//  MyActivityIndicator.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 24.12.2019.
//  Copyright © 2019 Павел Мишагин. All rights reserved.
//

import UIKit
import SwiftUI


struct ActivityIndicatorView: UIViewRepresentable {


  func makeUIView(context: Context) -> UIActivityIndicatorView {
    return UIActivityIndicatorView()
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    uiView.startAnimating()
  }


}
