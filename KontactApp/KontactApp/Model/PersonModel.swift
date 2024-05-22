//
//  PersonModel.swift
//  KontactApp
//
//  Created by Student on 13.02.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Person : Codable {
    
    @DocumentID var id : String!
    
    var Name : String
    var Email : String
    var Numero : String
    var ImageProfil : String
    
    
    enum Keys : String,CodingKey {
        
        case id
        case Name
        case Email
        case Numero_
        case ImageProfil
    }
}


