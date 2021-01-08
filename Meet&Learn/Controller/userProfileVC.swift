//
//  userProfileVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/24/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class userProfileVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userBirthDate: UILabel!
    @IBOutlet weak var userGenderSymbol: UIImageView!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var coverView: UIView!
    
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.makeRoundedCorners()
        Style.styleRedNormalButton(Button: signOutBtn)
        coverView.layer.cornerRadius = coverView.frame.size.height/1.9
        if let user = self.user {
            initData(imageUrl: user.imageUrl, firstName: user.firstName, lastName: user.lastName, userType: user.userType, email: user.email, phoneNumber: user.phoneNumber, birthDate: user.birthDate, gender: user.gender)
        }
        // Do any additional setup after loading the view.
    }
    
    func initUserData(user:User){
        self.user = user
    }

    func initData(imageUrl: String, firstName: String, lastName: String, userType: String, email: String, phoneNumber: String, birthDate: String, gender: String){
        do{
            self.userImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(imageUrl)")! as URL))
        }catch{}
        self.userName.text = "\(firstName) \(lastName)"
        self.userType.text = userType
        self.userMail.text = email
        self.userPhone.text = phoneNumber
        self.userBirthDate.text = birthDate
        if gender == "Male"{
            self.userGenderSymbol.image = UIImage(named: "maleSymbol")
        }else{
            self.userGenderSymbol.image = UIImage(named: "femaleSymbol")
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        }catch let signOutError as NSError{
            print("Error Signing Out :\(signOutError)")
        }
        if (Auth.auth().currentUser?.uid) == nil{
            let successfullSignOut = UIAlertController(title: "Successfull", message: "you signed out successfully", preferredStyle: .alert)

            successfullSignOut.addAction(UIAlertAction(title: "Ok", style: .default , handler: self.transitionToSigninVC(alert:)))
            self.present(successfullSignOut, animated: true, completion: nil)
        }
    }
    
    func transitionToSigninVC(alert: UIAlertAction) {
        let signinVC = storyboard?.instantiateViewController(withIdentifier: "SIVC") as! signinVC
        signinVC.modalPresentationStyle = .fullScreen
        presentDetail(signinVC)
    }
    
}
