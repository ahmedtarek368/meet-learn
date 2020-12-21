//
//  finishSignUpVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/15/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class finishSignUpVC: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    
    private var gender:String?
    private var firstName:String?
    private var lastName:String?
    private var email:String?
    private var password:String?
    private var birthDate:String?
    private var userType:String?
    private var phoneNumber:String?
    
    
    override func viewDidLayoutSubviews() {
        userProfileImage.makeRoundedCorners()
        selectBtn.makeRoundedCorners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorMessage.isHidden = true
        setDefaultUserImage()
        Style.styleNormalButton(Button: finishBtn)
    }
    
    func initData(firstName: String, lastName: String, email: String, password: String, birthDate: String, gender: String, userType: String, phoneNumber: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.birthDate = birthDate
        self.gender = gender
        self.userType = userType
        self.phoneNumber = phoneNumber
    }
    
    func setDefaultUserImage(){
        if gender == "Male" {
            userProfileImage.image = UIImage(named: "maleUser")
        }else if gender == "Female"{
            userProfileImage.image = UIImage(named: "femaleUser")
        }else{
            userProfileImage.image = UIImage(named: "")
        }
    }
    
    func checkUserProfileImage() -> String? {
        if userProfileImage.image == UIImage(named: "maleUser") || userProfileImage.image == UIImage(named: "femaleUser"){
            return "please select user profile picture"
        }
        return nil
    }
    
    func showError(message: String){
        errorMessage.text = message
        errorMessage.isHidden = false
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func selectBtnPressed(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    
    @IBAction func finishSignUpPressed(_ sender: Any) {
        
            let error = checkUserProfileImage()
            if error == nil{
                Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                    // Check for errors
                    if err != nil {
                        // There was an error creating the user
                        self.showError(message: "Error creating user")
                    }
                    else {
                        var imgUrl = ""
                        guard let imageSelected = self.userProfileImage.image else{
                            return
                        }
                        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else{
                            return
                        }
                        let storageRef = Storage.storage().reference(forURL: "gs://meet-and-learn-1709f.appspot.com")
                        let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                        let metaData = StorageMetadata()
                        metaData.contentType = "image/jpg"
                        storageProfileRef.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
                            if error != nil {
                                print(error?.localizedDescription as Any)
                            }
                            
                            storageProfileRef.downloadURL(completion: { (url, error) in
                                if let metaImageUrl = url?.absoluteString{
                                    imgUrl = metaImageUrl
                                    // User was created successfully, now store the first name and last name
                                    let db = Firestore.firestore()
                                    db.collection("Users").document("\(result!.user.uid)").setData(["firstname":self.firstName!, "lastname":self.lastName!, "birthdate": self.birthDate!, "gender": self.gender!, "phone":self.phoneNumber!, "usertype":self.userType!, "email":self.email!, "profileimageurl": imgUrl, "uid": result!.user.uid ]) { (error) in
                                        
                                        if error != nil {
                                            // Show error message
                                            self.showError(message: "Error saving user data")
                                        }
                                        else{
                                            Style.stylePressedButton(Button: self.finishBtn)
                                            let successfulySignedUpAlert = UIAlertController(title: "Successfull", message: "your account registered successfully", preferredStyle: .alert)
                               
                          successfulySignedUpAlert.addAction(UIAlertAction(title: "Ok", style: .default , handler: self.dissmissSignUpView(alert:)))
                                            self.present(successfulySignedUpAlert, animated: true, completion: nil)
                                        }
                                    }
                                }
                            })
                            
                        })
                    }
                }
            }else{
                showError(message: error!)
        }
    }
    
    func dissmissSignUpView(alert: UIAlertAction) {
        self.dismissDetail()
    }
    
}

extension finishSignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func showImagePickerControllerActionSheet(){
        let imageSourceAlert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Choose from camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        imageSourceAlert.addAction(photoLibraryAction)
        imageSourceAlert.addAction(cameraAction)
        self.present(imageSourceAlert, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userProfileImage.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            userProfileImage.image = originalImage
        }
        
    }
}
