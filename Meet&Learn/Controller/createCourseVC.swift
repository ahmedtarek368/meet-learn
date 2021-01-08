//
//  createCourseVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/25/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit

class createCourseVC: UIViewController {

    @IBOutlet weak var courseSubject: UITextField!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var courseOrganization: UITextField!
    @IBOutlet weak var certificateSystem: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    let courseFieldPicker = UIPickerView()
    let courseOrganizationPicker = UIPickerView()
    let certificateSystemPicker = UIPickerView()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    let courseFieldsArray = ["Marketing","Education","Language","Logistics","Sales","Accounting","Design/Art","Customer Service","IT/Software Development","Engineering - Construction/Civil","Engineering - Telecom/Technology","Engineering - Mechanical","Engineering - Oil & Gas","Human Resources"]
    let courseOrganizationsArray = ["Personal","EgyNile","NEN","Oxford Port Said","Harvest"]
    let certificateSystemsArray = ["Accredited Certification","Unaccredited certificate","No Certificate Awarded"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.alpha = 0
        createPickerViews()
        createDatePicker()
        styleView()
        hideKeyBoardWhenTappedAround()
    }

    func createDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePickingDatePressed))
        toolBar.setItems([doneBtn], animated: true)
        
        startDate.inputAccessoryView = toolBar
        endDate.inputAccessoryView = toolBar
        startDate.inputView = startDatePicker
        endDate.inputView = endDatePicker
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func donePickingDatePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        startDate.textAlignment = .center
        endDate.textAlignment = .center
        startDate.text = formatter.string(from: startDatePicker.date)
        endDate.text = formatter.string(from: endDatePicker.date)
        self.view.endEditing(true)
    }
    
    func styleView(){
        Style.styleNormalButton(Button: nextBtn)
        Style.styleTextField(courseSubject)
        Style.styleTextField(courseField)
        Style.styleTextField(courseOrganization)
        Style.styleTextField(certificateSystem)
        Style.styleTextField(startDate)
        Style.styleTextField(endDate)
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        }else{
            errorMessage.alpha = 0
            let finishCreateCourseVC : finishCreateCourseVC = self.storyboard?.instantiateViewController(withIdentifier: "FCCVC") as! finishCreateCourseVC
            finishCreateCourseVC.initData(courseSubject: courseSubject.text!, courseField: courseField.text!, courseOrganization: courseOrganization.text!, certificateSystem: certificateSystem.text!, startDate: startDate.text!, endDate: endDate.text!)
            finishCreateCourseVC.modalPresentationStyle = .fullScreen
            self.presentingViewController?.presentSecondaryDetail(finishCreateCourseVC)
        }
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if courseSubject.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please write course subject."
        }
        else if courseField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course field."
        }
        else if courseOrganization.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course organization."
        }
        else if certificateSystem.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course certificate system."
        }
        else if startDate.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course start date."
        }
        else if endDate.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please select course end date."
        }
        return nil
    }
    
    func showError(message: String){
        errorMessage.text = message
        errorMessage.alpha = 1
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

extension createCourseVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.courseFieldPicker{
            return courseFieldsArray.count
        }else if pickerView == self.courseOrganizationPicker{
            return courseOrganizationsArray.count
        }
        return certificateSystemsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.courseFieldPicker{
            return courseFieldsArray[row]
        }else if pickerView == self.courseOrganizationPicker{
            return courseOrganizationsArray[row]
        }
        return certificateSystemsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.courseFieldPicker{
            courseField.text = courseFieldsArray[row]
            courseField.resignFirstResponder()
        }else if pickerView == self.courseOrganizationPicker{
            courseOrganization.text = courseOrganizationsArray[row]
            courseOrganization.resignFirstResponder()
        }else{
            certificateSystem.text = certificateSystemsArray[row]
            certificateSystem.resignFirstResponder()
        }
    }
    
    func createPickerViews(){
        courseFieldPicker.delegate = self
        courseOrganizationPicker.delegate = self
        certificateSystemPicker.delegate = self
        
        courseFieldPicker.dataSource = self
        courseOrganizationPicker.dataSource = self
        certificateSystemPicker.dataSource = self
        
        courseField.inputView = courseFieldPicker
        courseOrganization.inputView = courseOrganizationPicker
        certificateSystem.inputView = certificateSystemPicker
    }
}
