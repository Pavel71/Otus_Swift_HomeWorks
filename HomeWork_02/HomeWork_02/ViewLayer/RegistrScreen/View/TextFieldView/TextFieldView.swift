//
//  TextFieldView.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 29.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI

//.validateFieldColor(
//     isValid: isValid,
//     isCurrentFieldValid: isCurrentFieldValid)

struct TextFieldView: View {
  
  var alertColor: Color = .red
  
  @Binding var textFieldInput: String
  
  var textFieldPlaceHolder = ""
  
  var textFieldState: TextFieldState = .editing
  
  var keyBoardType: UIKeyboardType = .default
  
  var isPasswordField = false
  
  
  var body: some View {
    
    HStack {
      
      if isPasswordField {
        
        SecureField(textFieldPlaceHolder, text: $textFieldInput)
        .validateFieldColor(state: textFieldState)
        .keyboardType(keyBoardType)
        
      } else {
        
        TextField(textFieldPlaceHolder, text: $textFieldInput)
        .validateFieldColor(state: textFieldState)
        .keyboardType(keyBoardType)
      }
      
      
      Image(systemName: textFieldState == .valid ? "checkmark.square": "exclamationmark.square")
        .opacity(
          (textFieldState != .editing) ? 1 : 0
          )
        .foregroundColor(textFieldState == .valid ? .green : alertColor)
    }
  }
}

extension View {
  
  func validateFieldColor(state: TextFieldState) -> some View {
    
    return self.modifier(TextFieldStateModifier(state: state))
  }
}


struct TextFieldStateModifier: ViewModifier {
  
  var state: TextFieldState = .editing
  
  
  func body(content: Content) -> some View {
    
    var color: Color
    
    switch  state {
      case .editing:
        color = .black
      case .noValid:
        color = .red
      case .valid:
        color = .green
    }
    return content.foregroundColor(color)
  }
}


