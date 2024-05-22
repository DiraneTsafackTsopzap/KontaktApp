//
//  Person_List_View.swift
//  KontactApp
//
//  Created by Student on 12.02.23.

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import Firebase

struct Person_List_View: View {
    
    
    @StateObject var PersonService_ = PersonService()
    @State private var RedirectToLoginPage = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        
        NavigationView {
            VStack (alignment: .leading) {
                Spacer()
                NavigationLink(destination: PersonAddView(), label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .padding()
                })
                
                List(PersonService_.ListPerson_, id: \.id) { person in
                    Person_List_Item_View(onDeleted: {
                        Task {
                            do {
                                try await PersonService_.Get_All_Personen_From_Db()
                            } catch {
                                // Handle the error
                            }
                        }
                    }, Personal: person)
                }
                
                .listRowSeparator(.hidden)
                .navigationBarTitle("Kontaktliste", displayMode: .inline)
                .onAppear {
                    Task {
                        do {
                            try await PersonService_.Get_All_Personen_From_Db()
                        } catch {
                            // Handle the error
                        }
                    }
                }
                
                Spacer()
                
            }
            .navigationBarItems(trailing: Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    RedirectToLoginPage = true
                    self.presentationMode.wrappedValue.dismiss()
                    
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }) {
                Image(systemName: "power")
                    .foregroundColor(.red)
                    .padding()
            }).background(
                NavigationLink(destination: Person_Login_View(), isActive: $RedirectToLoginPage) {
                    EmptyView()
                }).navigationBarBackButtonHidden(true)
        }
        
    }
    
    
    struct Person_List_Item_View: View {
        //@ObservedObject var personModel = PersonViewModel()
        var onDeleted: () -> Void
        
        let PersonService_ = PersonService()
        
        let Personal : Person
        
        @State var selectedPersonId: String?
        @State var showConfirmationDialog = false
        var body: some View {
            
            
            NavigationLink(destination: PersonEditView(person: Personal, documentId: Personal.id!)) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            
            ZStack  {
                
                Color.white.cornerRadius(8)
                HStack (){
                    Image_
                    InfoProfil_
                    Spacer()
                    Button(action: {
                        showConfirmationDialog = true
                        //  personModel.DeletePerson(DocumentId: Personal.id!)
                        
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    })}.padding()
                
            }.shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                .alert(isPresented: $showConfirmationDialog) {
                    Alert(
                        title: Text("Wollen Sie wirklich diese Person löschen?"),
                        primaryButton: .destructive(Text("Löschen")) {
                            // Löschen dieser Person
                            Task {
                                do {
                                    try await PersonService_.DeletePerson(DocumentId: Personal.id!)
                                    self.onDeleted()
                                } catch {
                                    // Handle the error
                                }
                            }
                        },
                        secondaryButton: .cancel(Text("Abbrechen"))
                    )
                }
        }
        
        
        private var Image_: some View {
            
            WebImage(url: URL(string: Personal.ImageProfil))
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle()
                    .strokeBorder(Color.white, lineWidth: 5)
                    .shadow(radius: 5)
                )
        }
        
        private var InfoProfil_: some View {
            
            return VStack(alignment: .leading, spacing: 5) {
                Text(Personal.Name)
                    .font(.title)
                    .lineLimit(2)
                Text(Personal.Numero)
                    .font(.headline)
                    .lineLimit(2)
                Text(Personal.Email)
                    .font(.subheadline)
                    .lineLimit(2)
            }
            
            struct Person_List_View_Previews: PreviewProvider {
                
                static var previews: some View {
                    Person_List_View()
                }
            }
        }
    }
}





