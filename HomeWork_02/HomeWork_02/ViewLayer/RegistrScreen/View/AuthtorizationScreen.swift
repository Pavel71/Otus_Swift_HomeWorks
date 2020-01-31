//
//  AuthtorizationScreen.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 27.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import SwiftUI
import Combine

struct AuthtorizationScreen: View {
  
  
  
  @Environment(\.presentationMode) var presentation
  
  @ObservedObject var autorizationVM: AutorizationVM
  
  
  var body: some View {
    
      
      VStack {
        
        Form {
          
          Section(
            header: Text("Requered")
              .font(.largeTitle)
              .foregroundColor(.black),
            footer: Text(
              // Если форма не прошла валидацию то вывести ошибку
              self.autorizationVM.formState == .noValid ? "\(autorizationVM.requredValidMessage)" : ""
            ).foregroundColor(Color.red)
          ) {
            
            TextFieldView(
              textFieldInput: $autorizationVM.login,
              textFieldPlaceHolder: "Email",
              textFieldState: autorizationVM.loginFieldState,
              keyBoardType: .emailAddress)
            
            TextFieldView(
              textFieldInput: $autorizationVM.password,
              textFieldPlaceHolder: "Password",
              textFieldState: autorizationVM.passwordFieldState,
              keyBoardType: .default,
              isPasswordField: true)
            
            TextFieldView(
              textFieldInput: $autorizationVM.phoneNumber,
              textFieldPlaceHolder: "PhoneNumber",
              textFieldState: autorizationVM.phoneNumberFieldState,
              keyBoardType: .phonePad)
            
            
          }
          
          Section(
            header: Text("Optional")
              .font(.largeTitle)
              .foregroundColor(.black),
            footer: Text(
              autorizationVM.optionalValidMessage
            )
          ) {
            
            TextFieldView(
              alertColor: .yellow,
              textFieldInput: $autorizationVM.fullName,
              textFieldPlaceHolder: "FullName",
              textFieldState: autorizationVM.fullNameFieldState,
              keyBoardType: .namePhonePad)
            
            
            DatePicker(selection: $autorizationVM.birthDay, displayedComponents: .date) {
              Text("Birthday").foregroundColor(.gray)
            }
          }
          

          Section {
            
            Button(action: {
              self.autorizationVM.isValid.toggle()
              
              print(self.autorizationVM.formState)
              
            }) {
              Text("Sign Up")
                .foregroundColor(.white)
              
            }.frame(maxWidth: .infinity, alignment: .center)
            
          }.listRowBackground(Color.blue)

        }// Form
        
        Button("Skip Auth") {
          self.presentation.wrappedValue.dismiss()
        }
      
      }// VStack
      
  }
}




struct AuthtorizationScreen_Previews: PreviewProvider {
  static var previews: some View {
    AuthtorizationScreen(autorizationVM: AutorizationVM())
  }
}
