//
//  NotesViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/23.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource
  {
    
    @IBOutlet weak var table: UITableView!
    
    var data: [String] = []
    var fileURL: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
        table.dataSource = self
        
    // giving the UI title
        self.title = "Notes"
        
    // large title
    self.navigationController?.navigationBar.prefersLargeTitles = true
        
    // "+" nav bar button to add new notes
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        
    // note editing button on nav bar
        self.navigationItem.leftBarButtonItem = editButtonItem
    
    // file URL
     let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
    // saving notes on device persistant storage
        fileURL = baseURL.appendingPathComponent("notes.txt")
        
        
    // loading the notes when app launches
        load()
    }
    
        // To add new notes
    @objc func addNote() {
        // to avoid adding new rows on edit
        if table.isEditing {
            return
        }
        let name: String = "Note \(data.count + 1)"
        data.insert(name, at:0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        save()
        
    }
    
    // how many rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // return a UITableView cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell    }
    
    
    // editing mode on upon pressing the edit button
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    // editing the cell content
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }

    // save notes to a file rather on user defaults
    
    func save() {
                  //UserDefaults.standard.set(data, forKey: "notes")
     let a = NSArray(array: data)
        
        // error handling if writing to file fails
        do {
            try a.write(to: fileURL)
        } catch {
            print("error writing file")
        }
    }
    
    func load() {
        if let loadedData: [String] = NSArray(contentsOf: fileURL) as? [String] {
            data = loadedData
            table.reloadData()
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
