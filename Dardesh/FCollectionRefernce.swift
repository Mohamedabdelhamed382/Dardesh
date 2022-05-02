//
//  FCollectionRefernce.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation
import Firebase


enum FCollectionRefernce: String {
    case User
}

func firestoreRefernce(_ collectionRefernce: FCollectionRefernce) -> CollectionReference {
    return Firestore.firestore().collection(collectionRefernce.rawValue)
}
