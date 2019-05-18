//
//  ViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/17.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     //self.saveData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // User authentication handling via AppTempData model
        
        AppTempData.userHandler = Auth.auth().addStateDidChangeListener{(auth, user) in
            // check whether is there a user who has already logged in ?
            if user == nil {
        self.performSegue(withIdentifier: "Login", sender: nil)
            } else
               {
        self.performSegue(withIdentifier: "Home", sender: nil)
    
               }
                                                }
                                                    }
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(AppTempData.userHandler!)
    }
    
     var ref: DatabaseReference!
    
    
    
}
