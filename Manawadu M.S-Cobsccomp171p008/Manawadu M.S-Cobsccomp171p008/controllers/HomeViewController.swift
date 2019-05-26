//
//  HomeViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/17.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var student:[Student] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase RTDB reference
        ref = Database.database().reference()
        
        self.cellRegistration()
       self.getStudentListData()
        self.tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // giving the UI title
        self.title = "Home"
        
    }
    
    // cell registration
    func cellRegistration() {
        self.tableView.register((UINib(nibName: "HomeTableViewCell", bundle: nil)), forCellReuseIdentifier: "HomeTableViewCell")
        }
    
    
    // to get student list data to array
func getStudentListData(){
        self.ref.child("StudentData/Students").observeSingleEvent(of: .value, with:{(snapshot) in
            
            var newstudent: [Student] = []
     
            if snapshot.childrenCount > 0 {
     
                for student in snapshot.children.allObjects as![DataSnapshot] {
                    
     //key, object creation
    
                    let studentObject = student.value as? [String: AnyObject]
     
   let student = Student(fName:studentObject!["fName"] as! String, lName:studentObject!["lName"] as! String, phoneNumber: studentObject!["phoneNumber"] as! Int, fbProfileURL: studentObject!["fbProfileURL"] as! String, city: studentObject!["city"] as! String, profileImageURL: studentObject!["profileImageURL"] as! String)
     
        newstudent.append(student)
                }
            }
        self.student = newstudent
            
         //reload the data to the view
     
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    @IBAction func doBtnSignOut(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // dismiss the signout page
        self.navigationController?.dismiss(animated: true)
        
    }
    // cell setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentCell = tableView.dequeueReusableCell(withIdentifier: "studentcell", for: indexPath) as! HomeTableViewCell
        
    let imgURL = URL(string:self.student[indexPath.row].profileImageURL)
        
        studentCell.profileImageView.kf.setImage(with: imgURL)
        studentCell.name.text = self.student[indexPath.row].fName + " " + self.student[indexPath.row].lName
        studentCell.city.text = self.student[indexPath.row].city
        return studentCell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showData" {
            let selectedIndex = sender as! Int
            let selectedStd = self.student[selectedIndex]
            
          let studentData = segue.destination as! viewUserDetailsViewController
            studentData.studentDetails = selectedStd
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showData", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
