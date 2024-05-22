//
//  UserModel.swift
//  KontactApp
//
//  Created by Student on 01.03.23.
//

import Foundation
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User : Codable {
    

    
    var Email : String
    var Password : String
  
    
    
    enum Keys : String,CodingKey {
        
       
        case Email
        case Password
     
    }
}
