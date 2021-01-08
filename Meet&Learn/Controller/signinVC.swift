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
    
    override func viewWillAppear(_ animated: Bool) {
        if (Auth.auth().currentUser?.uid) != nil {
            Services.readUserData(userid: Auth.auth().currentUser!.uid, completion: {(user) in
                let userType: String = self.checkUserType(user: user)
                
                if userType == "Learner"{
                    self.transitionToLearnerHomeVC(user: user)
                }else{
                    self.transitionToTeacherHomeVC(user: user)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Auth.auth().currentUser?.uid) != nil {
            Services.readUserData(userid: Auth.auth().currentUser!.uid, completion: {(user) in
                let userType: String = self.checkUserType(user: user)
                //self.currentUser = user
                if userType == "Learner"{
                    self.transitionToLearnerHomeVC(user: user)
                }else{
                    self.transitionToTeacherHomeVC(user: user)
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
                    self.showError(message: "Login Successful")
                    self.errorMessage.textColor = #colorLiteral(red: 0.3882352941, green: 0.7568627451, blue: 0.3137254902, alpha: 1)
                    Services.readUserData(userid: Auth.auth().currentUser!.uid, completion: {(user) in
                        let userType: String = self.checkUserType(user: user)
                        
                        if userType == "Learner"{
                            self.transitionToLearnerHomeVC(user: user)
                        }else{
                            self.transitionToTeacherHomeVC(user: user)
                        }
                    })
                }
            }
    }
    
    func transitionToLearnerHomeVC(user: User) {
        let learnerHomeVC = storyboard?.instantiateViewController(withIdentifier: "learnerHomeVC") as! learnerHomeVC
        learnerHomeVC.initUserData(user: user)
        learnerHomeVC.modalPresentationStyle = .fullScreen
        present(learnerHomeVC, animated: false, completion: nil)
    }
    
    func transitionToTeacherHomeVC(user: User) {
        let teacherHomeVC = storyboard?.instantiateViewController(withIdentifier: "teacherHomeVC") as! teacherHomeVC
        teacherHomeVC.initUserData(user: user)
        teacherHomeVC.modalPresentationStyle = .fullScreen
        //presentDetail(teacherHomeVC)
        present(teacherHomeVC, animated: false, completion: nil)
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

