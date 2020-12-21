//
//  Users.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/1/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation

class User{
    private(set) public var firstName: String!
    private(set) public var lastName: String!
    private(set) public var email: String!
    private(set) public var phoneNumber: String!
    private(set) public var birthDate: String!
    private(set) public var userType: String!
    
    init(firstName:String, lastName:String, email:String, phoneNumber:String, birthDate:String, userType:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.userType = userType
    }
    init(){}
}
