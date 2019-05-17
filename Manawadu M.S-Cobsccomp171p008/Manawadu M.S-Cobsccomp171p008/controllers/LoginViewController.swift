//
//  LoginViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/17.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // references to the UI elements
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var doBtnLogin: UIButton!
    
    @IBOutlet weak var doBtnForgotPassword: UIButton!
    
    @IBOutlet weak var doBtnSignUp: UIButton!
    
    
    @IBAction func doBtnLogin(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            // Login alert if prompted
            
            if error != nil{
                let alert = UIAlertController(title: "Error in Login", message: error? .localizedDescription, preferredStyle: .alert)
                
               alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                
            } else {
                strongSelf.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func doBtnForgotPassword(_ sender: UIButton) {
    }
    
    @IBAction func doBtnSignUp(_ sender: UIButton) {
        
        
        
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
