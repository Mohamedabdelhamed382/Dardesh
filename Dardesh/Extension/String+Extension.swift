//
//  String+Extension.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation

extension String {
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
}
