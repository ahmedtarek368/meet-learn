//
//  Course.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/31/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation
class Course{
    private(set) public var courseId: String!
    private(set) public var teacherId: String!
    private(set) public var courseSubject: String!
    private(set) public var courseField: String!
    private(set) public var courseOrganization: String!
    private(set) public var certificateSystem: String!
    private(set) public var startDate: String!
    private(set) public var endDate: String!
    private(set) public var courseSystem: String!
    private(set) public var attendanceAddress: String!
    private(set) public var notes: String!
    private(set) public var minimumEnrollments: String!
    private(set) public var currentEnrollments: String!
    private(set) public var usersEnrolled: [String]!
    
    init(courseId: String, teacherId: String, courseSubject: String, courseField: String, courseOrganization: String, certificateSystem: String, startDate: String, endDate: String, courseSystem: String, attendanceAddress: String, notes: String, minimumEnrollments: String, currentEnrollments: String, usersEnrolled: [String]){
        self.courseId = courseId
        self.teacherId = teacherId
        self.courseSubject = courseSubject
        self.courseField = courseField
        self.courseOrganization = courseOrganization
        self.certificateSystem = certificateSystem
        self.startDate = startDate
        self.endDate = endDate
        self.courseSystem = courseSystem
        self.attendanceAddress = attendanceAddress
        self.notes = notes
        self.minimumEnrollments = minimumEnrollments
        self.currentEnrollments = currentEnrollments
        self.usersEnrolled = usersEnrolled
    }
    
    init(){}
    
}

