//
//  Services.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/7/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import Foundation
import Firebase

class Services{
    
    static func readUserData(userid: String,completion: @escaping (_ data : User) -> ()){
        var user : User = User()
        let db = Firestore.firestore()
        db.collection("Users").document(userid).getDocument { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else {
                    let docData = document?.data()
                    user = User(userId: docData!["uid"] as! String, firstName: docData!["firstname"] as! String, lastName: docData!["lastname"] as! String, email: docData!["email"] as! String, phoneNumber: docData!["phone"] as! String, birthDate: docData!["birthdate"] as! String, userType: docData!["usertype"] as! String, gender: docData!["gender"] as! String, imageUrl: docData!["profileimageurl"] as! String)
                    completion(user)
            }
        }
    }
    
    static func readCoursesData(teacherId: String, completion: @escaping (_ data : [Course]) -> ()){
        var courses : [Course] = []
        let db = Firestore.firestore()
        db.collection("Courses").whereField("teacherId", isEqualTo: teacherId).getDocuments(){(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    courses.append(Course(courseId: docData["courseId"] as! String, teacherId: docData["teacherId"] as! String, courseSubject: docData["courseSubject"] as! String, courseField: docData["courseField"] as! String, courseOrganization: docData["courseOrganization"] as! String, certificateSystem: docData["certificateSystem"] as! String, startDate: docData["startDate"] as! String, endDate: docData["endDate"] as! String, courseSystem: docData["courseSystem"] as! String, attendanceAddress: docData["attendanceAddress"] as! String, notes: docData["notes"] as! String, minimumEnrollments: docData["minimumEnrollments"] as! String, currentEnrollments: docData["currentEnrollments"] as! String, usersEnrolled: docData["usersEnrolled"] as! [String]))
                }
                completion(courses)
            }
        }
        
    }
    
    static func readCoursesData(completion: @escaping (_ data : [Course]) -> ()){
        var courses : [Course] = []
        let db = Firestore.firestore()
        db.collection("Courses").getDocuments(){(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    courses.append(Course(courseId: docData["courseId"] as! String, teacherId: docData["teacherId"] as! String, courseSubject: docData["courseSubject"] as! String, courseField: docData["courseField"] as! String, courseOrganization: docData["courseOrganization"] as! String, certificateSystem: docData["certificateSystem"] as! String, startDate: docData["startDate"] as! String, endDate: docData["endDate"] as! String, courseSystem: docData["courseSystem"] as! String, attendanceAddress: docData["attendanceAddress"] as! String, notes: docData["notes"] as! String, minimumEnrollments: docData["minimumEnrollments"] as! String, currentEnrollments: docData["currentEnrollments"] as! String, usersEnrolled: docData["usersEnrolled"] as! [String]))
                }
                completion(courses)
            }
        }
        
    }
    
}
