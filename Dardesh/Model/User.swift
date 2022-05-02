//
//  User.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct User: Codable {
    var id: String?
    var username: String?
    var email:String?
    var pushId:String?
    var avatarLink:String?
    var status: String?
    
    static var currentUser:User? {
        if Auth.auth().currentUser != nil {
            if let data = userDefaults.data(forKey: kCurrentUser){
                let decoder = JSONDecoder()
                do {
                    let userobjct = try decoder.decode(User.self, from: data)
                    return userobjct
                } catch {
                    print(error)
                }
            }
        }
        return nil
    }
}

//MARK: - save user in userDefaults
func saveUserLocally(_ user: User) {
    let encoder  = JSONEncoder()
    do{
        let data = try encoder.encode(user)
        userDefaults.set(data, forKey: kCurrentUser)
    } catch( let error) {
        print(error.localizedDescription)
    }
}
