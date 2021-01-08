//
//  teacherHomeVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/5/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import SideMenu
//import Firebase

class teacherHomeVC: UIViewController {

    
    @IBOutlet weak var coursesTVC: UITableView!
    var currentUser : User?
    var courses : [Course] = []
    
    override func viewWillAppear(_ animated: Bool) {
        Services.readCoursesData(teacherId: (currentUser?.userId)!) { (courses) in
            self.courses = courses
            self.coursesTVC.reloadData()
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
        performSegue(withIdentifier: "SMS", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SMS"{
            let sideMenuNavVC = segue.destination as! SideMenuNavigationController
            let sideMenuTVC = sideMenuNavVC.viewControllers.first as! SideMenuTVC
            if let user = self.currentUser{
                sideMenuTVC.initUserData(user: user)
            }
        }
    }
    
    @IBAction func createCourseBtnPressed(_ sender: Any) {
        let createCourseVC : createCourseVC = self.storyboard?.instantiateViewController(withIdentifier: "CCVC") as! createCourseVC
        createCourseVC.modalPresentationStyle = .fullScreen
        presentDetail(createCourseVC)
    }
}

extension teacherHomeVC: UITableViewDelegate, UITableViewDataSource{
    
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
        let teacherCourseDetailsTVC = self.storyboard?.instantiateViewController(identifier: "TCDTVC") as! teacherCourseDetailsTVC
        teacherCourseDetailsTVC.modalPresentationStyle = .fullScreen
        let course = courses[indexPath.row]
        guard let user = currentUser else {return}
        teacherCourseDetailsTVC.dataInit(user: user, course: course)
        presentDetail(teacherCourseDetailsTVC)
    }
    
}
