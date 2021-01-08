//
//  finishCreateCourseVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/25/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase

class finishCreateCourseVC: UIViewController {

    @IBOutlet weak var courseSystem: UITextField!
    @IBOutlet weak var attendanceAddress: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var minimumEnrollments: UITextField!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var addressStack: UIStackView!
    
    private var courseSubject: String?
    private var courseField: String?
    private var courseOrganization: String?
    private var certificateSystem: String?
    private var startDate: String?
    private var endDate: String?
    
    let courseSystemPicker = UIPickerView()

    let courseSystemsArray = ["Online", "Blended"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.alpha = 0
        addressStack.isHidden = true
        createPickerViews()
        styleView()
        hideKeyBoardWhenTappedAround()
    }
    
    func styleView(){
        Style.styleNormalButton(Button: finishBtn)
        Style.styleTextField(courseSystem)
        Style.styleTextField(attendanceAddress)
        Style.styleTextField(notes)
        Style.styleTextField(minimumEnrollments)
    }
    
    func initData(courseSubject: String, courseField: String, courseOrganization: String, certificateSystem: String, startDate: String, endDate: String){
        self.courseSubject = courseSubject
        self.courseField = courseField
        self.courseOrganization = courseOrganization
        self.certificateSystem = certificateSystem
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if courseSystem.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course system."
        }
        else if minimumEnrollments.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select minimum enrollments number required to start."
        }
        return nil
    }
    
    func showError(message: String){
        errorMessage.text = message
        errorMessage.alpha = 1
    }

    @IBAction func finishBtnPressed(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        }else{
            let db = Firestore.firestore()
            let ref = db.collection("Courses").document()
            let docId = ref.documentID
            let teacherId = Auth.auth().currentUser!.uid
            let usersEnrolled : [String] = []
            let courseData : [String: Any] = ["courseId":docId,"teacherId":teacherId, "courseSubject":courseSubject!,"courseField":courseField!, "courseOrganization":courseOrganization!,"certificateSystem":certificateSystem!,"startDate":startDate!,"endDate":endDate!,"courseSystem":courseSystem.text!,"attendanceAddress":attendanceAddress.text!,"minimumEnrollments":minimumEnrollments.text!,"currentEnrollments":"0","notes":notes.text!,"usersEnrolled":usersEnrolled]
            ref.setData(courseData){(error) in
                if error != nil {
                    // Show error message
                    self.showError(message: "Error saving user data")
                }
                else{
                    Style.stylePressedButton(Button: self.finishBtn)
                    let successfullCreation = UIAlertController(title: "Successfull", message: "your course created successfully", preferredStyle: .alert)
       
                    successfullCreation.addAction(UIAlertAction(title: "Ok", style: .default , handler: self.dissmissCreateCourseView(alert:)))
                    self.present(successfullCreation, animated: true, completion: nil)
                }

            }
        }
        
    }
    
    func dissmissCreateCourseView(alert: UIAlertAction) {
        self.dismissDetail()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyBoardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoardView(){
        view.endEditing(true)
    }
    
}

extension finishCreateCourseVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return courseSystemsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courseSystemsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        courseSystem.text = courseSystemsArray[row]
        if courseSystem.text == "Blended"{
            addressStack.isHidden = false
        }else if courseSystem.text == "Online"{
            addressStack.isHidden = true
        }
        courseSystem.resignFirstResponder()
    }
    
    func createPickerViews(){
        courseSystemPicker.delegate = self
        courseSystemPicker.dataSource = self
        courseSystem.inputView = courseSystemPicker
    }
    
}
