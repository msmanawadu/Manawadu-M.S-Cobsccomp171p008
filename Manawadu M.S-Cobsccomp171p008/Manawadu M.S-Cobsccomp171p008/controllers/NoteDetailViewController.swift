//
//  NoteDetailViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/23.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    // captures user input text
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }
    
    // setting text from master ViewController
    func setText(t: String) {
        // modify the text
        text = t
        if isViewLoaded {
            //update the textview
            textView.text = t
        }
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
