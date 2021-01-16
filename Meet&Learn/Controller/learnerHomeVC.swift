//
//  learnerHomeVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/2/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SideMenu

class learnerHomeVC: UIViewController {

    @IBOutlet weak var coursesTVC: UITableView!
    
    var currentUser : User?
    var courses : [Course] = []
    
    override func viewWillAppear(_ animated: Bool) {
        Services.readCoursesData() { (courses) in
            self.courses = courses
            self.coursesTVC.reloadData()
            print(courses)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursesTVC.delegate = self
        coursesTVC.dataSource = self
    }
    
    func initUserData(user:User){
        self.currentUser = user
    }
    
    @IBAction func sideMenuBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "SMS2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SMS2"{
            let learnerSideMenuNavVC = segue.destination as! SideMenuNavigationController
            let learnerSideMenuTVC = learnerSideMenuNavVC.viewControllers.first as! learnerSideMenuTVC
            if let user = self.currentUser{
                learnerSideMenuTVC.initUserData(user: user)
            }
        }
    }
    
}

extension learnerHomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let courseCell = tableView.dequeueReusableCell(withIdentifier: "CC", for: indexPath) as! courseCell
        let course = courses[indexPath.row]
        courseCell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        courseCell.initCourseCellData(courseSubject: course.courseSubject, courseField: course.courseField, courseOrganization: course.courseOrganization)
        return courseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let learnerCourseDetailsVC = self.storyboard?.instantiateViewController(identifier: "LCDVC") as! learnerCourseDetailsVC
        learnerCourseDetailsVC.modalPresentationStyle = .fullScreen
        let course = courses[indexPath.row]
        var courseTeacher = User()
        Services.readUserData(userid: course.teacherId) { (teacher) in
            courseTeacher = teacher
            guard let user = self.currentUser else {return}
            learnerCourseDetailsVC.dataInit(user: user, course: course, courseTeacher: courseTeacher)
            self.presentDetail(learnerCourseDetailsVC)
        }
    }
    
}
