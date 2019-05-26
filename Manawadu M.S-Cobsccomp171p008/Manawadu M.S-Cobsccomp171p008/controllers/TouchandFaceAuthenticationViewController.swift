//
//  TouchandFaceAuthenticationViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/23.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchandFaceAuthenticationViewController: UIViewController {
    
    let context: LAContext = LAContext()
    @IBOutlet weak var authenticateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checking the authentication type
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            if context.biometryType == .faceID {
                authenticateBtn.setImage(UIImage(named: "face"), for: UIControl.State.normal)
                
            } else if context.biometryType == .touchID {
                authenticateBtn.setImage(UIImage(named: "touch"), for: UIControl.State.normal)
                
            }
        }
        
        // giving the UI title
        self.title = "My Profile"
    }
    
    
    @IBAction func doButtonAuthenticate(_ sender: UIButton) {
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Identify yourself!") { (correct, nil) in
                
                if correct {
                    
                    DispatchQueue.main.async {
                        
                        // go to the next screen
                        self.performSegue(withIdentifier: "userProfileView", sender: self)
                    }
                } else {
                    print("Invalid Password")
                }
            }
        } else {
            print("Doesn't support Biometric Authentication ")
        }
    }
}
