//
//  AuthtorizationVM.swift
//  HomeWork_02
//
//  Created by Павел Мишагин on 27.01.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import Foundation
import Combine


enum TextFieldState {
  
  case editing,valid,noValid
  
}

enum FormValidState {
  case editing,valid,noValid
}

class AutorizationVM : ObservableObject {
  
  
  
  
  
  // Input
  // required
  @Published var login           = ""
  @Published var password        = ""
  @Published var phoneNumber     = ""
  // Non required input
  @Published var fullName        = ""
  @Published var birthDay        = Date()
  
  // Output
  @Published var isValid               = false
  
  var isLoginValid          = false
  var isPasswordValid       = false
  var isPhoneNumberValid    = false
  
  var isFullNameValid       = true
  var isBirthDayValid       = true
  
  
  var requredValidMessage: String {
    
    return loginMessage + " " + passwordMessage + " " + phoneNumberMessage
  }
  var optionalValidMessage: String {
    return fullNameMessage
  }
  
  
  // Message
  var loginMessage         = ""
  var passwordMessage      = ""
  var phoneNumberMessage   = ""
  
  
  var fullNameMessage      = ""
  var birthDayMessage      = ""
  
  
  
  @Published var loginFieldState      : TextFieldState = .editing
  @Published var passwordFieldState   : TextFieldState = .editing
  @Published var phoneNumberFieldState: TextFieldState = .editing
  @Published var fullNameFieldState   : TextFieldState = .editing
  @Published var birthDayFieldState   : TextFieldState = .editing
  
  
  @Published var formState : FormValidState = .editing
  
  
  
  // Теперь мне нужна логика! я ввожу данные по лоигну и получаю их
  
  var cancellabel: Set<AnyCancellable> = []
  
  init() {
    
    // Нажатие на кнопку SignUP
    
    // Завернем в Defered чтобы не вызывался при инициализации
    _ = Deferred {
       self.$isValid.eraseToAnyPublisher()
    }.sink(receiveValue: { (_) in
      
      self.loginFieldState           = self.isLoginValid       ? .valid : .noValid
      self.passwordFieldState    = self.isPasswordValid    ? .valid : .noValid
      self.phoneNumberFieldState = self.isPhoneNumberValid ? .valid : .noValid
      self.fullNameFieldState    = self.isFullNameValid    ? .valid : .noValid
      self.birthDayFieldState    = self.isBirthDayValid    ? .valid : .noValid
           
           
           self.formValid()
      }).store(in: &cancellabel)

    
    
    // Теперь у меня такая задача объеденить выход данных с валидации полей в 1 паблишер который скажит валидна ли форма или нет!
    
    // Похорошему эти паблишеры объединить в 1
    
    $login
      .debounce(for: 0.4, scheduler: RunLoop.main)
      .removeDuplicates()
      .map(loginValidator)
      .sink { (isLoginValid, message) in
        
        self.formState       = .editing
        self.loginFieldState = .editing // Когда идет печать текста мы ставим стайт в editing
        self.loginMessage    = message
        self.isLoginValid    = isLoginValid
        
      }.store(in: &cancellabel)
    
    $password
      .debounce(for: 0.4, scheduler: RunLoop.main)
      .removeDuplicates()
      .map(passwordValidator)
      .sink { (isPasswordValid, message) in
        
        self.formState          = .editing
        self.passwordFieldState = .editing // Когда идет печать текста мы ставим стайт в editing
        self.passwordMessage    = message
        self.isPasswordValid    = isPasswordValid
        
    }.store(in: &cancellabel)
    
    $phoneNumber
      .debounce(for: 0.4, scheduler: RunLoop.main)
      .removeDuplicates()
      .map(phoneNumberValidator)
      .sink { (isPhoneValid, message) in
        
        self.formState             = .editing
        self.phoneNumberFieldState = .editing // Когда идет печать текста мы ставим стайт в editing
        self.phoneNumberMessage    = message
        self.isPhoneNumberValid    = isPhoneValid
        
    }.store(in: &cancellabel)
    
    
    $fullName
      .debounce(for: 0.4, scheduler: RunLoop.main)
      .removeDuplicates()
      .map(fullNameValidator)
      .sink { (isFullNameValid, message) in
        
        self.formState          = .editing
        self.fullNameFieldState = .editing // Когда идет печать текста мы ставим стайт в editing
        self.fullNameMessage    = message
        self.isFullNameValid    = isFullNameValid
        
    }.store(in: &cancellabel)

    
  }
  
  
 
  
}

// MARK: Form Valid

extension AutorizationVM {
  
  
  // Нужно доработать эту функцию потомучто нихера не поняотно шо тут происходит и добавить сюда FullName если уж началаи его вводить то форму не отпускать
  
  private func formValid() {

    var requeredStateArray = [loginFieldState,passwordFieldState,phoneNumberFieldState,fullNameFieldState]
    
    // Если поле не редактировалось то убирем его из проверямого массива
    if fullName.isEmpty {
      requeredStateArray.removeLast()
    }
    
    let setState = Set(requeredStateArray)

    // 1. // Дубликатов нет проверяем поле!
    if setState.count == 1 {
      
      let state = setState.first!
      formState = state == .valid  ? .valid : .noValid
      
    } else {
      // Есть дубликаты значит продолжаем редактирование
      formState = .noValid
    }
    
    
    
    
  }
  
}

// MARK: FullName Validate

extension AutorizationVM {
  
  private func fullNameValidator(fullNameString: String) -> (Bool, String) {
     if fullNameString.isEmpty {
         return (false,"")
         
       } else if fullNameString.count < 3 {
         let message = "Полное имя слишком короткое"
         return (false, message)
         
       } else {
         // Добавить валидацию на сложность Полного имени !
         let isValid = isWhitespaces(fullName: fullNameString)
      return (isValid, isValid == false ? "Добавьте пробел" : "" )
     }
   }
  
  private func isWhitespaces(fullName: String) -> Bool {
      let regex = try? NSRegularExpression(pattern: #"[ ]+"#, options: .caseInsensitive)
      return regex?.firstMatch(in: fullName, options: [], range: NSMakeRange(0, fullName.count)) != nil
  }
  
}

// MARK: PhoneNumber Validate

extension AutorizationVM {
  
  private func phoneNumberValidator(phoneString: String) -> (Bool, String) {
    if phoneString.isEmpty {
        return (false,"")
        
      } else if phoneString.count < 9 {
        let message = "Телефон не может содержать меньше 8 цифр"
        return (false, message)
        
      } else {
        // Добавить валидацию на сложность пароля!
        return (true, "")
    }
  }
  
}

// MARK: Password Validate

extension AutorizationVM {
  
  private func passwordValidator(passwordString: String) -> (Bool, String) {
    if passwordString.isEmpty {
        return (false,"")
        
      } else if passwordString.count < 8 {
        let message = "Пароль не может быть меньше 8 символов"
        return (false, message)
        
      } else {
        // Добавить валидацию на сложность пароля!
        return (true, "")
    }
  }
}

// MARK: Email Validate

extension AutorizationVM {
  
  // Функция принимает строку с email и валидирует ее - возвращает Bool и сообщение что не так с лоигном!
   private func loginValidator(loginString: String) -> (Bool, String) {
     
       if loginString.isEmpty {
         return (false,"")
         
       } else if loginString.count < 5 {
         let message = "Логин не может быть меньше 5 символов"
         return (false, message)
         
       } else {
         
         let isValid = regexValidateEmail(login: loginString)
         
         let message = isValid == false ?  "Логин не подходит" : ""
         return (isValid, message)
     }
     
   }
   
   private func regexValidateEmail(login: String) -> Bool {
     
     let regex = try? NSRegularExpression(pattern: #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#, options: .caseInsensitive)
     return regex?.firstMatch(in: login, options: [], range: NSMakeRange(0, login.count)) != nil
   }
}
