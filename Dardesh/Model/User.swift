//
//  User.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation
import FirebaseFirestoreSwift
import RealmSwift

struct User: Codable {
    var id: String?
    var username: String?
    var email:String?
    var pushId:String?
    var avatarLink:String?
    var status: String?
}

//MARK: - save user in userDefulats
func saveUserLocally(_ user: User) {
    let encoder  = JSONEncoder()
    
    do{
        
        let data = try encoder.encode(user)
        userDefaults.set(data, forKey: kCurrentUser)
        
    } catch( let error) {
        print(error.localizedDescription)
    }
}
