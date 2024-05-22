//
//  PersonEditView.swift
//  KontactApp
//
//  Created by Student on 14.02.23.
//

import SwiftUI

extension String {
    
    var IsNumeric : Bool {
        
        Double (self) != nil
    }
}

struct PersonEditView: View {
    
    let PersonService_ = PersonService()
    @State var person: Person
    @State var documentId: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form{
            
            VStack(alignment: .center) {
                
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.cyan)
                    
                    TextField("Name", text: $person.Name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 1)
                        )
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "phone.circle")
                        .foregroundColor(.cyan)
                    TextField("Telefon", text: $person.Numero)
                        .padding().keyboardType(.numberPad)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 1)
                        )
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.cyan)
                    TextField("E-Mail", text: $person.Email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10).keyboardType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 1)
                        )
                    
                    
                }
                Spacer()
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.cyan)
                    TextField("ImageBildUrl", text: $person.ImageProfil)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 1)
                        )
                }
                Spacer()
            }.navigationBarTitle("Edit Person")
                .navigationBarItems(trailing: Button("Speichern") {
                    self.PersonService_.updatePerson(self.person, documentId: self.documentId)
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

