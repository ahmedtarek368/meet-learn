//
//  LoggingInViewControll.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 11/27/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class signinVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var signInView: UIView!
    
    override func viewDidLayoutSubviews() {
        email.delegate = self
        password.delegate = self
        Style.styleTextField(email)
        Style.styleTextField(password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Auth.auth().currentUser?.uid) != nil {
            readUserData(userid: Auth.auth().currentUser!.uid, completion: {(user) in
                let userType: String = self.checkUserType(user: user)
                
                if userType == "Learner"{
                    self.transitionToLearnerHomeVC()
                }else{
                    self.transitionToTeacherHomeVC()
                }
            })
        }
        signInView.bindToKeyboard()
        hideKeyBoardWhenTappedAround()
        Style.styleNormalButton(Button: signinBtn)
        errorMessage.alpha = 0
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
            
            let email = self.email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                // Couldn't sign in
                if error != nil {
                    self.showError(message: error!.localizedDescription)
                }else{
                    Style.stylePressedButton(Button: self.signinBtn)
                    self.errorMessage.text = "Login Successful"
                    self.errorMessage.textColor = #colorLiteral(red: 0.3882352941, green: 0.7568627451, blue: 0.3137254902, alpha: 1)
                    self.readUserData(userid: Auth.auth().currentUser!.uid, completion: {(user) in
                        let userType: String = self.checkUserType(user: user)
                        
                        if userType == "Learner"{
                            self.transitionToLearnerHomeVC()
                        }else{
                            self.transitionToTeacherHomeVC()
                        }
                    })
                }
            }
    }
    
    func transitionToLearnerHomeVC() {
        let learnerHomeVC = storyboard?.instantiateViewController(withIdentifier: "learnerHomeVC") as! learnerHomeVC
        learnerHomeVC.modalPresentationStyle = .fullScreen
        presentDetail(learnerHomeVC)
    }
    //teacherHomeVC
    func transitionToTeacherHomeVC() {
        let teacherHomeVC = storyboard?.instantiateViewController(withIdentifier: "teacherHomeVC") as! teacherHomeVC
        teacherHomeVC.modalPresentationStyle = .fullScreen
        presentDetail(teacherHomeVC)
    }
    
    func readUserData(userid: String,completion: @escaping (_ data : User) -> ()){
        var user : User = User()
        let db = Firestore.firestore()
        db.collection("Users").document(userid).getDocument { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else {
                    let docData = document?.data()
                    user = User(firstName: docData!["firstname"] as! String, lastName: docData!["lastname"] as! String, email: docData!["email"] as! String, phoneNumber: docData!["phone"] as! String, birthDate: docData!["birthdate"] as! String, userType: docData!["usertype"] as! String)
                    completion(user)
            }
        }
    }
    func checkUserType(user: User) -> String{
        if user.userType == "Learner"{
            return "Learner"
        }else{
            return "Teacher"
        }
    }
    
    func showError(message: String){
        errorMessage.alpha = 1
        errorMessage.text = message
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyBoardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoardView(){
        view.endEditing(true)
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupVC
        signupVC.modalPresentationStyle = .fullScreen
        presentDetail(signupVC)
        
    }
}

