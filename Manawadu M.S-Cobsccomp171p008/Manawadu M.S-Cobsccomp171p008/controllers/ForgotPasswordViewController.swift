//
//  ForgotPasswordViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/19.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var tfForgotPassword: UITextField!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func doBtnResetPassword(_ sender: UIButton) {
        
        
        let email = self.tfForgotPassword.text!
        
        if email != "" {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                } else {
         self.dismiss(animated: true, completion: nil)
                }
            }
        }
   
    // Hide the SW keyboard
    self.tfForgotPassword.resignFirstResponder()
    }
    
    //Hide the SW keyboard when the user touch anywhere else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func doBtnCancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        // Hide the SW keyboard
        self.tfForgotPassword.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
