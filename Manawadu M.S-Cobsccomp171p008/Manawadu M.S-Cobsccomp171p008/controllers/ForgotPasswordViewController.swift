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
    }
    
    
    @IBAction func doBtnCancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
