//
//  String+Extension.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/05/2022.
//

import Foundation

extension String {
  func whiteSpacesRemoved() -> String {
    return self.filter { $0 != Character(" ") }
  }
}
