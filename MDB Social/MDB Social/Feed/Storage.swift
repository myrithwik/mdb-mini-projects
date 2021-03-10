//
//  Storage.swift
//  MDB Social
//
//  Created by Rithwik Mylavarapu on 3/9/21.
//

import Foundation
import FirebaseStorage

class FIRStorage {
    static let shared = FIRStorage()
    let storage = Storage.storage()
}
