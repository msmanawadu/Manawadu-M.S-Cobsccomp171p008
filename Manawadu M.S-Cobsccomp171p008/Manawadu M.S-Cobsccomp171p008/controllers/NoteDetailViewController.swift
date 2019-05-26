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
    
    // to capture user input text
    var text: String = ""
    
    // create a property of master VC reference
    var masterView: NotesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        
        // set small title for Note
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // to automatically display the phone keypad
        textView.becomeFirstResponder()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
        
        // to hold the keypad
        textView.resignFirstResponder()
    }
    
}
