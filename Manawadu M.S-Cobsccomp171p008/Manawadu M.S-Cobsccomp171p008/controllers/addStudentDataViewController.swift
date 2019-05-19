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

    
    // Student Data variables
    var firstName: String = ""
    var lastName: String = ""
    var fbProfileURL: String = ""
    var phoneNo: Int = 0
    var cityOf: String = ""
    var profileImgURL: String = ""
    
    
    
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
    }
    
    
    @IBAction func doBtnCancel(_ sender: UIButton) {
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cancelBtn
        
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor.red.cgColor
        cancelBtn.layer.cornerRadius = cancelBtn.bounds.height / 2

        // BUTTON BORDER
        self.saveBtn.layer.borderWidth = 1.0
        
        // BUTTON CORNER ROUND - saveBtn
        self.saveBtn.layer.cornerRadius = self.saveBtn.bounds.height / 2

        // Do any additional setup after loading the view.
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension addStudentDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            
            let imageName = imageURL.lastPathComponent
            print("Image Name: \(imageName)")
            let imageExtension = imageURL.pathExtension
            print("Image Extension: \(imageExtension)")
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.profileImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}


