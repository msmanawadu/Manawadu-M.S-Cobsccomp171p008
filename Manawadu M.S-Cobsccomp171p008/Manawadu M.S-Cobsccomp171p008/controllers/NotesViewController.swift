//
//  NotesViewController.swift
//  Manawadu M.S-Cobsccomp171p008
//
//  Created by Sandeepa Manawadu on 2019/05/23.
//  Copyright © 2019 Sandeepa Manawadu. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
  {
    
    @IBOutlet weak var table: UITableView!
    
    var data: [String] = []
    var fileURL: URL!
    // reference for currently selected row
    var selectedRow: Int = -1
    // store the text at detail ViewController
    var newRowText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // handling the data in the table
        table.dataSource = self
        
    // table row selection interactivity via the delegate
        table.delegate = self
        
    // giving the UI title
        self.title = "Notes"
        
    // large title
    self.navigationController?.navigationBar.prefersLargeTitles = true
    // always display in large title
    self.navigationItem.largeTitleDisplayMode = .always
        
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
    
    // calling again
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    }
    
    
    
    
        // To add new notes
    @objc func addNote() {
        // to avoid adding new rows on edit
        if table.isEditing {
            return
        }
        let name: String = ""
        data.insert(name, at:0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)    }
    
    // prepare for notedetail ViewController to appear
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: NoteDetailViewController = segue.destination as! NoteDetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        // set up masterView property
        detailView.masterView = self
        //  detailView.masterView = self
        detailView.setText(t: data[selectedRow])
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
