//
//  addStudentDataViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/18.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos

class addStudentDataViewController: UIViewController {
    
    // image accesing & database handling variables
    var imgPick: UIImagePickerController!
    var imageDownloadURL: String = ""
    var dataBaseRef: DatabaseReference!
    var rootImage: String = ""

    
    // Student Data variables
    var firstName: String = ""
    var lastName: String = ""
    var fbProfileURL: String = ""
    var phoneNo: Int = 0
    var cityOf: String = ""
    var profileImgURL: String = ""
 
    
    // property observer method to validate the image download
    var didSetVariable = 0 {
        didSet{
            self.saveStudentData()
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
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
        
        self.firstName = self.fName.text!
        self.lastName = self.lName.text!
        self.fbProfileURL = self.FbProfileURL.text!
        self.phoneNo = Int(self.phoneNumber.text!)!
        self.cityOf = self.city.text!
        
        imageUploading()
        
        // Testing the passed values in the console
        print(firstName, lastName, fbProfileURL, phoneNo, cityOf)
        
        //Hide the SW keyboard
        self.fName.resignFirstResponder()
        self.lName.resignFirstResponder()
        self.phoneNumber.resignFirstResponder()
        self.city.resignFirstResponder()
        self.FbProfileURL.resignFirstResponder()
        
    }
    
    //Hide the SW keyboard when the user touch anywhere else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func doBtnCancel(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cancelBtn
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.07474343349, blue: 0, alpha: 1)
        cancelBtn.layer.cornerRadius = cancelBtn.bounds.height / 2

        // saveBtn
        self.saveBtn.layer.borderWidth = 1.0
        self.saveBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.07706925133, blue: 1, alpha: 1)
        self.saveBtn.layer.cornerRadius = self.saveBtn.bounds.height / 2
        
        // image Picker modification
        imgPick = UIImagePickerController()
        imgPick.allowsEditing = true
        imgPick.sourceType = .photoLibrary
        imgPick.delegate = self
        
        // imageView configuration
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(openImgPick))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imgTap)
        
        doBtnAddPhoto.addTarget(self, action: #selector(openImgPick), for: .touchUpInside)

    
    }
    
    // openImgPick function Definition
    
    @objc func openImgPick(_sender: Any) {
        self.present(imgPick, animated: true, completion: nil)
    }

    // Image uploading function
    
    func imageUploading() {
        
        let storageReference = Storage.storage().reference()
        
        // Data in memory
        
        guard let data = self.profileImage.image!.jpegData(compressionQuality: 0.75) else {return}
        let image: UIImage = self.profileImage.image!
        print("Image Data: \(image)")
        
        
        // create a reference to the file you want to upload
        let selectedImage = storageReference.child("profile images/\(rootImage)")
        
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
    
    
    // Firebase RTDB data saving function
    func saveStudentData() {
        
    dataBaseRef = Database.database().reference().child("StudentData/Students").childByAutoId()
        
        // passing data as a JSON key-value pair
        
        let student = ["fName": self.firstName,
                       "lName": self.lastName,
                       "fbProfileURL": self.fbProfileURL,
                       "phoneNumber": self.phoneNo,
                       "city":  self.cityOf,
        "profileImageURL": self.imageDownloadURL] as [String: Any]
        
        print(student)
        
        self.dataBaseRef!.setValue(student) {error, ref in
            
            if error != nil{
                let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension addStudentDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            
            let imageName = imageURL.lastPathComponent
            print("Image Name: \(imageName)")
            let imageExtension = imageURL.pathExtension
            print("Image Extension: \(imageExtension)")
            self.rootImage = imageName
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.profileImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


