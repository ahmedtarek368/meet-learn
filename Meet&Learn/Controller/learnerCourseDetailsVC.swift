//
//  learnerCourseDetailsVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/12/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase
import SwiftyStarRatingView

class learnerCourseDetailsVC: UIViewController {

    var currentUser = User()
    var course = Course()
    var courseTeacher = User()
    
    
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
    @IBOutlet weak var enrollBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        for userId in course.usersEnrolled {
            if currentUser.userId == userId {
                enrollBtn.setTitle("Enrolled", for: .normal)
                enrollBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                Style.stylePressedButton(Button: enrollBtn)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style.styleNormalButton(Button: enrollBtn)
        updateViewData(course: course, user: currentUser, courseTeacher: courseTeacher)
        teacherImg.makeRoundedCorners()
        // Do any additional setup after loading the view.
    }
    
    func dataInit(user: User, course: Course, courseTeacher: User){
        self.currentUser = user
        self.course = course
        self.courseTeacher = courseTeacher
    }
    
    func updateViewData(course: Course, user: User, courseTeacher: User){
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
        self.teacherName.text = "\(courseTeacher.firstName!) \(courseTeacher.lastName!)"
        do{
            self.teacherImg.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(courseTeacher.imageUrl!)")! as URL))
        }catch{}
        
        setupCoverImg(Field: course.courseField!)
        setupOrgImg(organization: course.courseOrganization!)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func enrollBtnPressed(_ sender: Any) {
        if enrollBtn.titleLabel!.text == "Enroll"{
            enrollBtn.setTitle("Enrolled", for: .normal)
            Style.stylePressedButton(Button: enrollBtn)
            
            Services.enrollUserToCourse(userId: currentUser.userId!, courseId: course.courseId!)
            Services.addCourseToUserData(userId: currentUser.userId!, courseId: course.courseId!)
        }else{
            enrollBtn.setTitle("Enroll", for: .normal)
            Style.styleNormalButton(Button: enrollBtn)
            
            Services.unenrollUserFromoCourse(userId: currentUser.userId!, courseId: course.courseId!)
            Services.removeCourseFromoUserData(userId: currentUser.userId!, courseId: course.courseId!)
        }
        
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
