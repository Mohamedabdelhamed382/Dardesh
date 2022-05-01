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
    func loginUserWith(email: String, password:String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool ) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] (authResult, error) in
            if error == nil && authResult!.user.isEmailVerified {
                authResult!.user.sendEmailVerification { error in
                    completion(error, true)
                    self.downloadUserFromFirestor(userId: authResult!.user.uid)
                }
            } else {
                completion(error, false)
            }
        }
    }
    
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
    
    //MARK: - Resend Verification Email
    func resendVerificationEmailWith(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
            })
        })
    }
    
    //MARK: - Reset Password
    func resetPasswordWith(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    //MARK: - saveUserToFirestore
    private func saveUserToFirestore(_ user: User) {
        do {
            try firestoreRefernce(.User).document(user.id!).setData(from: user)
        } catch (let error ) {
            print (error)
        }
    }
    
    //MARK: - downloadUserFromFirestor
    private func downloadUserFromFirestor(userId: String) {
        firestoreRefernce(.User).document(userId).getDocument { [self] (document, error) in
            guard let userDocument = document else { print("no data Found"); return }
            
            let result = Result {
                try userDocument.data(as: User.self)
            }
            
            switch result {
            case .success(let userObject):
                if let user = userObject {
                    saveUserLocally(user)
                } else {
                    print ("Documnet Doesnot Exist")
                }
            case .failure(let error):
                print ("error decoding user", error .localizedDescription)
            }
        }
    }
}
