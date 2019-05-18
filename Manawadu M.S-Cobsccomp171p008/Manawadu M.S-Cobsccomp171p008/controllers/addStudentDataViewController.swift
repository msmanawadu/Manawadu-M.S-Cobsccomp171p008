//
//  addStudentDataViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/18.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit

class addStudentDataViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageURL: UIImageView!
    
    
    @IBOutlet weak var doBtnAddPhoto: UIButton!
    
    
    @IBOutlet weak var fName: UITextField!
    
    
    @IBOutlet weak var lName: UITextField!
    
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBOutlet weak var city: UITextField!
    
    
    @IBOutlet weak var FbProfileURL: UITextField!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    
    @IBAction func doBtnAddPhoto(_ sender: UIButton) {
    }
    
    
    @IBAction func doBtnSave(_ sender: UIButton) {
    }
    
    
    @IBAction func doBtnCancel(_ sender: UIButton) {
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BUTTON BORDER
        self.saveBtn.layer.borderWidth = 1.0
        
        // BUTTON CORNER ROUND
        self.saveBtn.layer.cornerRadius = self.saveBtn.bounds.height / 2

        // Do any additional setup after loading the view.
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
