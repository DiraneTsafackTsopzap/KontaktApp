//
//  PersonLogin.swift
//  KontactApp
//
//  Created by Student on 01.03.23.
//

import SwiftUI
import Firebase

struct Person_Login_View: View {
    @State private var User_Validation = ValidateUser ()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var isAuthenticated: Bool = false
    
    @State var errorMessage = ""
    @State var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                Spacer()               // Placez une Image Ici
                Image("loginimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 50)
                
                
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.cyan)
                        TextField("E-Mail", text: $User_Validation.Email_)
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
                        Image(systemName: "lock")
                            .foregroundColor(.cyan)
                        Spacer()
                        SecureField("Passwort", text: $User_Validation.Password_)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10).keyboardType(.emailAddress)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cyan, lineWidth: 1)
                            )
                    }
                    Spacer()
                    ForEach(User_Validation.Nachrichten, id: \.self) { message in
                        
                        Text(message)
                    }
                    // // // : {} ? =  []  () "" !
                }
                .navigationBarTitle("Anmelden")
                .navigationBarItems(trailing: Button("Login") {
                    
                    if User_Validation.Validate(){
                        
                        Auth.auth().signIn(withEmail: User_Validation.Email_, password: User_Validation.Password_){
                            (AuthDataResult,error ) in
                            
                            if let error = error {
                                errorMessage = error.localizedDescription
                                showingAlert = true                                    }
                            else {
                                isAuthenticated = true
                            }
                            
                            
                        }
                        
                    }
                })
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                
            }.sheet(isPresented: $isAuthenticated) { // Utilisez la variable 'authenticated' pour déclencher la navigation
                Person_List_View()
            }
            
        }
    }
    
    
    struct PersonLogin_Previews: PreviewProvider {
        static var previews: some View {
            Person_Login_View()
        }
    }
}
