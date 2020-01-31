//
//  ConditionalModifire.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 30.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI


extension View {
// If condition is met, apply modifier, otherwise, leave the view untouched
  public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
    Group {
      if condition {
        self.modifier(modifier)
      } else {
        self
      }
    }
  }
}
