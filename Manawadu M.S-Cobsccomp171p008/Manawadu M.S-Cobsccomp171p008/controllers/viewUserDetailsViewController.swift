//
//  viewUserDetailsViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/20.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Kingfisher

class viewUserDetailsViewController: UIViewController {
    
    var studentDetails: Student!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelFBProfileURL: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgURL = URL(string: studentDetails.profileImageURL)
    profileImageView.kf.setImage(with: imgURL)
        
        labelFirstName.text = studentDetails.fName
        labelLastName.text = studentDetails.lName
        labelCity.text = studentDetails.city
        labelPhoneNumber.text = String(studentDetails.phoneNumber!)
        labelFBProfileURL.text = studentDetails.fbProfileURL
     
        // ImageView round edges
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height / 8
        
        // giving the UI title
        self.title = "Friend Details"
    }
}
