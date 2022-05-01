//
//  User.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    var id: String?
    var username: String?
    var email:String?
    var pushId:String?
    var avatarLink:String?
    var status: String?
}
