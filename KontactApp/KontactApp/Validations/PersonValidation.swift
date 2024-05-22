//
//  PersonValidation.swift
//  KontactApp
//
//  Created by Student on 19.02.23.
//

import Foundation



struct ValidateInfo {
    
    var Name_  : String = ""
    var Number_  : String = ""
    var Email_  : String = ""
    var ImageBildUrl_  : String = ""
    var Password_  : String = ""
    
    var  Nachrichten : [String] = []
    
    
    mutating func Validate () -> Bool {
        Nachrichten = []
        
        if  Name_.isEmpty {
            Nachrichten.append("Bitte geben sie einen Kontaktnamen ein")
        }
      
        
        if  Number_.isEmpty {
            Nachrichten.append("Bitte geben Sie eine Telefonnummer ein")
        }
        if  Email_.isEmpty {
                    Nachrichten.append("Die Email muss angegeben werden")
                }
        else if !isEmailValidCheck(Email_) {
                    Nachrichten.append("Bitte Geben Sie ein Valid Email")
                }
        
        
        if  ImageBildUrl_.isEmpty {
            Nachrichten.append("Geben sie bitte die Bild-URL ein")
        }
        
        else if !isImageURLValidCheck(ImageBildUrl_) {
            Nachrichten.append("Bitte geben Sie eine gültige Bild-URL ein (.jpg oder .png)")
        }
        
        if  !Number_.Is_Numeric {
            Nachrichten.append("Die Telefonnummer darf keine Buchstaben enthalten")
        }
        
        
        
       
        
        
        return Nachrichten.count == 0
    }
    func isEmailValidCheck(_ email: String) -> Bool {
            let regExMatchEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicateEmail = NSPredicate(format:"SELF MATCHES %@", regExMatchEmail)
            return predicateEmail.evaluate(with: email)
        }
    
    func isImageURLValidCheck(_ imageURL: String) -> Bool {
        let regExMatchImageURL = "^https?://(?:[a-z0-9\\-]+\\.)+[a-z]{2,6}(?:/[^/#?]+)+\\.(?:jpg|png)$"
        let predicateImageURL = NSPredicate(format: "SELF MATCHES %@", regExMatchImageURL)
        return predicateImageURL.evaluate(with: imageURL.lowercased())
   
}

}

// Email Validation in Swift UI
// https://swiftspeedy.com/email-validation-in-swift/
