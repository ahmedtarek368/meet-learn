//
//  teacherCourseDetailsTVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/7/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class teacherCourseDetailsTVC: UITableViewController {
    
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var courseSubject: UILabel!
    @IBOutlet weak var courseOrganization: UILabel!
    @IBOutlet weak var organizationImg: UIImageView!
    @IBOutlet weak var courseField: UILabel!
    @IBOutlet weak var courseSystem: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var certificateSystem: UILabel!
    @IBOutlet weak var ratingsNumber: UILabel!
    @IBOutlet weak var teacherImg: UIImageView!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var rate: SwiftyStarRatingView!
    
    var currentUser = User()
    var course = Course()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teacherImg.makeRoundedCorners()
        updateViewData(course: course, user: currentUser)
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func dataInit(user: User, course: Course){
        self.currentUser = user
        self.course = course
    }
    
    func updateViewData(course: Course, user: User){
        self.courseSubject.text = course.courseSubject
        self.courseOrganization.text = "from \(course.courseOrganization!)"
        self.courseField.text = course.courseField
        if course.courseSystem == "Online"{
            self.courseSystem.text = "100% \(course.courseSystem!)"
        }else{
            self.courseSystem.text = "50% Online"
        }
        self.startDate.text = course.startDate!
        self.endDate.text = course.endDate!
        self.certificateSystem.text = course.certificateSystem!
        self.ratingsNumber.text = "445 Ratings"
        self.rate.value = 4.5
        self.teacherName.text = "\(user.firstName!) \(user.lastName!)"
        do{
            self.teacherImg.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(user.imageUrl!)")! as URL))
        }catch{}
        
        setupCoverImg(Field: course.courseField!)
        setupOrgImg(organization: course.courseOrganization!)
        
    }
    
    func setupOrgImg(organization: String){
        switch(organization){
        case "EgyNile" :
            self.organizationImg.image = UIImage(named: "egyNile")
            break
        case "NEN" :
            self.organizationImg.image = UIImage(named: "nen")
            break
        case "Oxford Port Said" :
            self.organizationImg.image = UIImage(named: "oxfordPortsaid")
            break
        default:
            self.organizationImg.image = UIImage(named: "harvest")
        }
    }

    func setupCoverImg(Field: String){
        switch(Field){
        case "Accounting" :
            self.coverImg.image = UIImage(named: "accounting")
            break
        case "Marketing" :
            self.coverImg.image = UIImage(named: "Marketing")
            break
        case "Education" :
            self.coverImg.image = UIImage(named: "education")
            break
        case "Language" :
            self.coverImg.image = UIImage(named: "language")
            break
        case "Human Resources" :
            self.coverImg.image = UIImage(named: "human resourses")
            break
        case "IT/Software Development" :
            self.coverImg.image = UIImage(named: "IT")
            break
        case "Engineering - Construction/Civil" :
            self.coverImg.image = UIImage(named: "EngineeringCivil")
            break
        case "Engineering - Telecom/Technology" :
            self.coverImg.image = UIImage(named: "IT")
            break
        case "Engineering - Mechanical" :
            self.coverImg.image = UIImage(named: "EngineeringMechanical")
            break
        case "Engineering - Oil & Gas" :
            self.coverImg.image = UIImage(named: "EngineeringOil")
            break
        default:
            self.coverImg.image = UIImage(named: "accounting")
        }
    }
    
}
