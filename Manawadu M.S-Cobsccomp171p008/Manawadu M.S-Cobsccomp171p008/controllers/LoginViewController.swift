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

class LoginViewController: UIViewController,  GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
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
    // S
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                
                let alert = UIAlertController(title: "Error in LogIn", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            // User is signed in
            self.dismiss(animated: true, completion: nil)
            print(authResult!.user.email)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
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
