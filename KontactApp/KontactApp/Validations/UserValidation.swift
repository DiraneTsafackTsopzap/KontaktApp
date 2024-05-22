//
//  UserValidation.swift
//  KontactApp
//
//  Created by Student on 01.03.23.
//

import Foundation

struct ValidateUser {
    
 
    var Email_  : String = ""
    var Password_  : String = ""
    
    var  Nachrichten : [String] = []
    
    
    mutating func Validate () -> Bool {
        Nachrichten = []
        
       
        if  Password_.isEmpty {
            Nachrichten.append("Password Is Empty")
        }
        
       
        if  Email_.isEmpty {
                    Nachrichten.append("Email Is Empty")
                }
        else if !isEmailValidCheck(Email_) {
                    Nachrichten.append("Bitte Geben Sie ein Valid Email")
                }
      
        
        
       
        
        
        return Nachrichten.count == 0
    }
    func isEmailValidCheck(_ email: String) -> Bool {
            let regExMatchEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicateEmail = NSPredicate(format:"SELF MATCHES %@", regExMatchEmail)
            return predicateEmail.evaluate(with: email)
        }
    
   
   
}


