//
//  learnerSideMenuTVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/8/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import UIKit

class learnerSideMenuTVC: UITableViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var currentUser : User?

    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.makeRoundedCorners()
        if currentUser != nil {
            self.userName.text = "\(currentUser!.firstName!) \(currentUser!.lastName!)"
            do{
                self.userImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(currentUser!.imageUrl!)")! as URL))
            }catch{}
        }
    }

    func initUserData(user:User){
        self.currentUser = user
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: Any) {
        let userProfileVC : userProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "UPVC") as! userProfileVC
        if let user = self.currentUser {
            userProfileVC.initUserData(user: user)
        }
        userProfileVC.modalPresentationStyle = .fullScreen
        presentDetail(userProfileVC)
    }

}
