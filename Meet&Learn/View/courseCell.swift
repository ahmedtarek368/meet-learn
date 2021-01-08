//
//  courseCell.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/1/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import UIKit

class courseCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var courseSubject: UILabel!
    @IBOutlet weak var courseOrganization: UILabel!
    @IBOutlet weak var organizationImage: UIImageView!
    

    func initCourseCellData(courseSubject: String, courseField: String, courseOrganization: String){
        self.courseSubject.text = courseSubject
        self.courseOrganization.text = "from \(courseOrganization)"
        
        switch(courseField){
        case "Accounting" :
            self.coverImage.image = UIImage(named: "accounting")
            break
        case "Marketing" :
            self.coverImage.image = UIImage(named: "Marketing")
            break
        case "Education" :
            self.coverImage.image = UIImage(named: "education")
            break
        case "Language" :
            self.coverImage.image = UIImage(named: "language")
            break
        case "Human Resources" :
            self.coverImage.image = UIImage(named: "human resourses")
            break
        case "IT/Software Development" :
            self.coverImage.image = UIImage(named: "IT")
            break
        case "Engineering - Construction/Civil" :
            self.coverImage.image = UIImage(named: "EngineeringCivil")
            break
        case "Engineering - Telecom/Technology" :
            self.coverImage.image = UIImage(named: "IT")
            break
        case "Engineering - Mechanical" :
            self.coverImage.image = UIImage(named: "EngineeringMechanical")
            break
        case "Engineering - Oil & Gas" :
            self.coverImage.image = UIImage(named: "EngineeringOil")
            break
        default:
            self.coverImage.image = UIImage(named: "accounting")
        }
        
        switch(courseOrganization){
        case "EgyNile" :
            self.organizationImage.image = UIImage(named: "egyNile")
            break
        case "NEN" :
            self.organizationImage.image = UIImage(named: "nen")
            break
        case "Oxford Port Said" :
            self.organizationImage.image = UIImage(named: "oxfordPortsaid")
            break
        default:
            self.organizationImage.image = UIImage(named: "harvest")
        }
}
/*
 Personal","EgyNile","NEN","Oxford Port Said","Harvest
 */
}
