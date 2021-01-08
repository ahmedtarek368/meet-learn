//
//  Users.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/1/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation

class User{
    private(set) public var userId: String!
    private(set) public var firstName: String!
    private(set) public var lastName: String!
    private(set) public var email: String!
    private(set) public var phoneNumber: String!
    private(set) public var birthDate: String!
    private(set) public var userType: String!
    private(set) public var gender: String!
    private(set) public var imageUrl: String!
    
    init(userId: String, firstName: String, lastName: String, email: String, phoneNumber: String, birthDate: String, userType: String, gender: String, imageUrl: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.userType = userType
        self.gender = gender
        self.imageUrl = imageUrl
    }
    init(){}
}
