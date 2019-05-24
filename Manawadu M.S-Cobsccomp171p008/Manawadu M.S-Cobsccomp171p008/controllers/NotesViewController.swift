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
        save()
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
    
    // save notes to persistent storage using user defaults
    func save() {
         UserDefaults.standard.set(data, forKey: "notes")
       }
    
    func load() {
        if let loadedData: [String] = UserDefaults.standard.value(forKey: "notes") as? [String] {
            data = loadedData
            table.reloadData()
        }
    }
}
