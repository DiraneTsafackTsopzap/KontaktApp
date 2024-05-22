//
//  PersonService.swift
//  KontactApp
//
//  Created by Student on 06.04.23.
//

import Foundation

import Firebase

class PersonService: ObservableObject {
    
    @Published var ListPerson_ : [Person] = []
    let Reference = Firestore.firestore()
    
    func InsertPerson (persondata : Person,completion :@escaping(Bool)->()){
        
        do {
            let _ = try Reference.collection("Person").addDocument(from: persondata){
                
                (error) in
                
                if error != nil {
                    completion(false)
                }
                
                completion(true)
            }
        }
        catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------  Delete a Data in Firestore Db
    // // // : {} ? =  []  () "" !=
    
    
    
    func DeletePerson(DocumentId: String) async throws {
        let documentRef = Firestore.firestore().collection("Person").document(DocumentId)
        
        do {
            try await documentRef.delete()
            print("Document deleted successfully.")
        } catch {
            print("Error deleting document: \(error.localizedDescription)")
            throw error
        }
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------  Update a Data in Firestore Db
    
    func updatePerson(_ person: Person, documentId: String) {
        let personData = [
            "Name": person.Name,
            "Email": person.Email,
            "Numero": person.Numero,
            "ImageProfil": person.ImageProfil,
            
        ]
        Reference.collection("Person").document(documentId).setData(personData) { error in
            if let error = error {
                print("Error updating person: \(error.localizedDescription)")
            } else {
                print("Person successfully updated in Firestore")
                
            }
        }
    }
    
    func Get_All_Personen_From_Db  () async throws {
        let personsRef = Reference.collection("Person")
        
        do {
            let snapshot = try await personsRef.getDocuments()
            var persons = [Person]()
            
            for document in snapshot.documents {
                let name = document.get("Name") as! String
                let id = document.documentID as! String
                let email = document.get("Email") as! String
                let image = document.get("ImageProfil") as! String
                let number = document.get("Numero") as! String
                let person = Person(id: id, Name: name, Email: email,  Numero: number, ImageProfil: image)
                persons.append(person)
            }
            
            ListPerson_ = persons
        } catch let error as NSError {
            print("Error retrieving persons: \(error.localizedDescription)")
            throw FirestoreError.dataRetrievalFailed
        }
    }
}

enum FirestoreError: Error {
    case dataRetrievalFailed
}
