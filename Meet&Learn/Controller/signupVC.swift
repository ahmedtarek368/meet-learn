//
//  signupViewController.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 11/30/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class signupVC: UIViewController {
    
    @IBOutlet weak var learnerBtn: UIButton!
    @IBOutlet weak var teacherBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var userType = ""
    var textFieldYAxis : CGFloat = 0.0
    let genderArray = ["Male","Female","Other"]
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        createDatePicker()
        createGenderPickerView()
        hideKeyBoardWhenTappedAround()
        createKeyboardObservers()
        //nextBtn.bindToKeyboard()
    }
    
    @IBAction func learnerBtnPressed(_ sender: Any) {
        Style.stylePressedButton(Button: learnerBtn)
        Style.styleNormalButton(Button: teacherBtn)
        userType = "Learner"
    }
    
    @IBAction func teacherBtnPressed(_ sender: Any) {
        Style.stylePressedButton(Button: teacherBtn)
        Style.styleNormalButton(Button: learnerBtn)
        userType = "Teacher"
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        }else if userType == "" {
            showError(message: "please select whether you are a learner or a teacher")
        }else if phoneNumber.text == ""{
            showError(message: "please enter your phone number")
        }else if birthDate.text == "" {
            showError(message: "please enter your date of birth")
        }else{
            errorMessage.isHidden = true
            
            let firstName = self.firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = self.lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let gender = self.gender.text!
            let birthDate = self.birthDate.text!
            let userType = self.userType
            let phoneNumber = self.phoneNumber.text!
            
            guard let finishSignUpVC = self.storyboard?.instantiateViewController(withIdentifier: "finishSignUpVC") as? finishSignUpVC else{ return }
            finishSignUpVC.initData(firstName: firstName, lastName: lastName, email: email, password: password, birthDate: birthDate, gender: gender, userType: userType, phoneNumber: phoneNumber)
            finishSignUpVC.modalPresentationStyle = .fullScreen
            Style.stylePressedButton(Button: nextBtn)
            self.presentingViewController?.presentSecondaryDetail(finishSignUpVC)
        }
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        if gender.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please select your gender"
        }
        if phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill phone number field"
        }
        if phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill phone number field"
        }
        let characterSet = CharacterSet.init(charactersIn: "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#$%^&*()~?/><|\\+=_-")
        if phoneNumber.text?.trimmingCharacters(in: characterSet) == ""{
            return "Please enter correct phone number"
        }
        // Check if the password is secure
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    func createDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePickingDatePressed))
        toolBar.setItems([doneBtn], animated: true)
        
        birthDate.inputAccessoryView = toolBar
        birthDate.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func donePickingDatePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        birthDate.textAlignment = .center
        birthDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func showError(message: String){
        errorMessage.text = message
        errorMessage.isHidden = false
    }
    
    func styleElements(){
        Style.styleNormalButton(Button: learnerBtn)
        Style.styleNormalButton(Button: teacherBtn)
        Style.styleTextField(firstName)
        Style.styleTextField(lastName)
        Style.styleTextField(birthDate)
        Style.styleTextField(email)
        Style.styleTextField(password)
        Style.styleTextField(phoneNumber)
        Style.styleTextField(gender)
        Style.styleNormalButton(Button: nextBtn)
        errorMessage.isHidden = true
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyBoardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoardView(){
        view.endEditing(true)
    }
   
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

extension signupVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genderArray[row]
        gender.resignFirstResponder()
    }
    
    func createGenderPickerView(){
        genderPicker.delegate = self
        genderPicker.dataSource = self
        gender.inputView = genderPicker
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldYAxis = textField.frame.origin.y
        print(textFieldYAxis)
        return true
    }
    
    func createKeyboardObservers(){
        gender.delegate = self
        phoneNumber.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let endingFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - textFieldYAxis
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            if self.textFieldYAxis >= endingFrame.origin.y{
             self.view.frame.origin.y += deltaY
            }else{
                self.view.frame.origin.y = 0
            }
        }, completion: nil)
        
    }
}
