//
//  SideMenuTVC.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/22/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Firebase

class SideMenuTVC: UITableViewController {
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

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
