//
//  userProfileView.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/20.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher


class userProfileView: UIViewController {
    
    
    var fname: String = ""
    let lName: String = ""
    let phoneNumber: Int = 0
    let profImg: String = ""
    let age: Int = 0
    let bDay: String = ""
    
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var labelFirstName: UILabel!
    
    
    @IBOutlet weak var labelLastName: UILabel!
    
    
    @IBOutlet weak var labelPhoneNumber: UILabel!
    
    
    @IBOutlet weak var labelFBProfileURL: UILabel!
    
    
    @IBOutlet weak var labelCity: UILabel!
    
    
    var ref: DatabaseReference!
    
   
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()

        // Do any additional setup after loading the view.
    }
    
    func getUserData() {
        let userId = Auth.auth().currentUser?.uid
        //print(userId)
        
        Database.database().reference().child("user/profile").child(userId!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            
            if let userprof = DataSnapshot.value as? [String : AnyObject]{
                self.labelFirstName.text! = userprof["fName"] as! String
                self.labelFirstName.text! = userprof["lName"] as! String
                self.labelPhoneNumber.text! = String(userprof["phoneNumber"] as! Int)
                
                
                
                
                
                
                
                let imgURL = URL(string: userprof["profImag"] as! String)
              self.profileImageView.kf.setImage(with: imgURL)
            }
            
        }, withCancel: nil)
//        ref.child("user/profile/").child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in

           // print(snapshot)

//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)

//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
