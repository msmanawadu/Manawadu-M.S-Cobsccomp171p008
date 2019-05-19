//
//  MyProfilePageViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/19.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos

class MyProfilePageViewController: UIViewController {
    
    // image accesing & database handling variables
    var imgPick: UIImagePickerController!
    var imageDownloadURL: String = ""
    var dataBaseRef: DatabaseReference!
    var rootImage: String = ""
    
   // Student Data variables
    var firstName: String = ""
    var lastName: String = ""

    var phoneNo: Int = 0

    var birthDay: String = ""
    var userAge: Int = 0
    
    
    // property observer method to validate the image download
   var didSetVariable = 0 {
       didSet{
           self.signup()
       }
   }
    
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var BtnAddImage: UIButton!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
   @IBAction func doBtnSave(_ sender: UIButton) {

    self.firstName = self.tfFirstName.text!
    self.lastName = self.tfLastName.text!
    self.userAge = Int(self.tfAge.text!)!
    self.birthDay = self.tfBirthday.text!
    self.phoneNo = Int(self.tfPhoneNumber.text!)!
    
        imageUploading()
//
//        // Testing the passed values in the console
//        print(firstName, lastName, fbProfileURL, phoneNo, cityOf)
   }
    
    
    @IBAction func doBtnAddImage(_ sender: UIButton) {
    }
    
    
    @IBAction func doBtnClear(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image Picker modification
        
        imgPick = UIImagePickerController()
        imgPick.allowsEditing = true
        imgPick.sourceType = .photoLibrary
        imgPick.delegate = self
        
        // imageView configuration
        
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(openImgPick))
        profilePicView.isUserInteractionEnabled = true
        profilePicView.addGestureRecognizer(imgTap)
        
            BtnAddImage.addTarget(self, action: #selector(openImgPick), for: .touchUpInside)
        
        

        // Do any additional setup after loading the view.
    }
    
    
    // openImgPick function Definition
    
    @objc func openImgPick(_sender: Any) {
        self.present(imgPick, animated: true, completion: nil)
    }
    
    // Image uploading function
    
    func imageUploading() {

        let storageReference = Storage.storage().reference()

//        // Data in memory

        guard let data = self.profilePicView.image!.jpegData(compressionQuality: 0.75) else {return}
        let image: UIImage = self.profilePicView.image!
        print("Image Data: \(image)")


        // create a reference to the file you want to upload
        let selectedImage = storageReference.child("user/\(rootImage)")

        // upload the file the path "profile images/selectedImage.jpg"

        let uploadTask = selectedImage.putData(data, metadata: nil) {
            (metadata, error) in
            guard let metadata = metadata else {
                // when error ocuured
                return
            }

            print("Meta Data:\(metadata)")

            // metadata contains file meta data such as size, content-type

            let size = metadata.size

            // You can also access to download URL after upload

            let url = selectedImage.downloadURL{(url, error) in

                guard let downloadURL = url else {

                    print("Error Img: \(error)")
                    return
                }

                self.imageDownloadURL = downloadURL.absoluteString

                if self.imageDownloadURL != "" {
                    self.didSetVariable = 1

                }
                print("Download URL \(self.imageDownloadURL)")
            }
            print("URL: \(self.imageDownloadURL)")
        }
   }
    

    // Sign Up new users
    
    func signup() {
        Auth.auth().createUser(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { authResult, erroruser in
            
            if erroruser == nil && authResult != nil {
                guard let uid = Auth.auth().currentUser?.uid else {
                    return
                }
                self.dataBaseRef = Database.database().reference().child("user/profile/\(uid)")
                
                let user = ["fName": self.firstName,
                            "lName": self.lastName,
                            "age": self.userAge,
                            "phoneNumber": self.phoneNo,
                            "birthDay": self.birthDay] as [String: Any]
                
            
            self.dataBaseRef!.setValue(user){errorsave, ref in
                
                if errorsave != nil{
                    let alert = UIAlertController(title: "Signup Error", message: errorsave?.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
          
        } else {
            
            if erroruser != nil{
                let alert = UIAlertController(title: "Signup Error", message: (erroruser as! String) , preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
            
            
            
            
            
        }
        
}
    
    
    
    
}

extension MyProfilePageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            
            let imageName = imageURL.lastPathComponent
            print("Image Name: \(imageName)")
            let imageExtension = imageURL.pathExtension
            print("Image Extension: \(imageExtension)")
            self.rootImage = imageName
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            self.profilePicView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
