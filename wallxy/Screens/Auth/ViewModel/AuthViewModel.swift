//
//  AuthViewModel.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 03/06/24.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore



class AuthViewModel: ObservableObject {
    
    @Published var emailId: String = ""
    @Published var password: String = ""
    @Published var imageUrl: String = ""
    @Published var name: String = ""
    @Published var showLoginErrorAlert: Bool = false
    @Published var loginErrorText: String = ""
    @Published var isLoggedIn: Bool = false
    
    func disableShowLoginErrorAlert() {
        self.showLoginErrorAlert = false
    }
    
    //##################################
    //MARK: Register Function Firebase
    //##################################
    func firebaseRegister(email emailId: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: emailId, password: password) { authResult, error in
            if error != nil {
                debugPrint("Error in Creating account ----> \(String(describing: error?.localizedDescription ?? "undefined error"))")
            } else {
                debugPrint("Successfully created account")
                
                //MARK: - Updating account details in Firestore Database
                let db = Firestore.firestore()
                
                Task {
                    do {
                        let ref = try await db.collection("users").addDocument(data: [
                            "email": emailId,
                            "password": password,
                            "name": name,
                            "imageUrl": ""
                        ])
                        DispatchQueue.main.async {
                            self.emailId = emailId
                            self.imageUrl = ""
                            self.name = name
                        }
                        debugPrint("NEW ACCOUNT DOC ID ---> \(ref.documentID)")
                    } catch let err {
                        debugPrint("FIRESTORE ERROR -> \(String(describing: err))")
                    }
                }
            }
        }
    }
    
    //##################################
    //MARK: Login Function Firebase
    //##################################
    func firebaseLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if error != nil {
                debugPrint("Error in Signing in ----> \(String(describing: error?.localizedDescription ?? "undefined error"))")
                DispatchQueue.main.async {
                   self.showLoginErrorAlert = true
                   self.loginErrorText = String(describing: error?.localizedDescription ?? "Something went wrong")
                }
            } else {
                print("Successfully logged in")
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
                
                let db = Firestore.firestore()
                
                Task {
                    do {
                        let querySnapshot = try await db.collection("users").whereField("email", isEqualTo: email).getDocuments()
                        guard let document = querySnapshot.documents.first else {
                            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No matching documents found"])
                        }
                        
                        let data = document.data()
                        guard let email = data["email"] as? String, let imageUrl = data["imageUrl"] as? String, let name = data["name"] as? String else {
                            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data is missing or invalid"])
                        }
                        
                        DispatchQueue.main.async {
                            self.emailId = email
                            self.imageUrl = imageUrl
                            self.name = name
                        }
                        
                    } catch {
                        print("Error fetching documents: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.loginErrorText = error.localizedDescription
                            self.showLoginErrorAlert = true
                        }
                    }
                }
            }
        }
    }
}
