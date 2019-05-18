//
//  Student.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/18.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import Foundation

class Student {
    
    let fName: String!
    let lName: String!
    let phoneNumber: Int!
    let fbProfileURL: String!
    let city: String!
    let profileImageURL: String!
    
    // Initializer
    init(fName: String, lName: String, phoneNumber: Int, fbProfileURL: String, city: String, profileImageURL: String)

    // Initializer body
    {
    self.fName = fName
    self.lName = lName
    self.phoneNumber = phoneNumber
    self.fbProfileURL = fbProfileURL
    self.city = city
    self.profileImageURL = profileImageURL
    }
    
}
