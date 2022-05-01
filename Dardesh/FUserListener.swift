//
//  FUserListener.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation
import Firebase

class FUserListener {
    
    static let shared = FUserListener()
    private init() {}
    
    //MARK: - Login
    
    //MARK: - Register
    func registerUserWith(email: String, password:String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] (authResult, error) in
            completion(error)
            if error == nil {
                authResult!.user.sendEmailVerification { error in
                    completion(error)
                }
            }
            
            if authResult?.user != nil {
                let user = User(id: authResult?.user.uid, username: email, email: email, pushId: "", avatarLink: "", status: "Hey, Iam using Dardesh")
                self.saveUserToFirestore(user)
            }
        }
    }
    
    private func saveUserToFirestore(_ user: User) {
        do {
            try firestoreRefernce(.User).document(user.id!).setData(from: user)
        } catch (let error ) {
            print (error)
        }
    }
}
