//
//  PersonAddView.swift
//  KontactApp
//
//  Created by Student on 12.02.23.
//

import SwiftUI



extension String {
    
    var Is_Numeric : Bool {
        
        Double (self) != nil
    }
}
struct PersonAddView: View {
    let PersonService_ = PersonService()
    @State private var info = ValidateInfo ()
    
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    // Redirection zu einer Seite
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    var body: some View {
        Form{
            VStack(alignment: .center) {
                
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.cyan)
                    
                    TextField("Name", text: $info.Name_)
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
                    TextField("Number", text: $info.Number_)
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
                    TextField("Email", text: $info.Email_)
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
                    TextField("ImageBildUrl", text: $info.ImageBildUrl_)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 1)
                        )
                }
                Spacer()
                ForEach(info.Nachrichten, id: \.self) { message in
                    
                    Text(message)
                }
            }
            .navigationBarTitle("Add Person")
            .navigationBarItems(trailing: Button("Add") {
                
                if info.Validate(){
                    
                    let PersonData = Person(
                        
                        Name : self.info.Name_,
                        Email: self.info.Email_,
                        Numero : self.info.Number_,
                        ImageProfil : self.info.ImageBildUrl_
                    )
                    
                    self.PersonService_.InsertPerson(persondata: PersonData) { (status) in
                        if status {   
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        else {
                            info.Nachrichten.append("Failed to save the person")
                        }
                    }
                }
            })
        }
    }
}





