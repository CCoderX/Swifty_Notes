//
//  ViewController.swift
//  Swifty_Note
//
//  Created by user on 8/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource
{
    @IBOutlet weak var notesTable: UITableView!
    var notes : [note] = [note()]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notesTable.register(UINib(nibName: "noteTableViewCell", bundle: nil), forCellReuseIdentifier: "noteCell")
        notesTable.delegate = self
        notesTable.dataSource = self
    }
    func getNotes()
    {
        let realm = try! Realm()
        notes = Array( realm.objects(note.self))
        notesTable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        notes = [note()]
//    }
    
   
    @IBAction func addNote(_ sender: Any)
    {
        
    }
}
extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! noteTableViewCell
        cell.descriptionTxt.text = notes[indexPath.row].noteDescription
        let image = imageSaver.fetchImage(imageName: notes[indexPath.row].noteImage ?? "")
        cell.noteImage.image = image
        cell.noteNumberTxt.text = notes[indexPath.row].noteTitle
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(notes[indexPath.row])
        }
        notes.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        addNoteViewController.editedNote = notes[indexPath.row]
        performSegue(withIdentifier: "addNoteSegue", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.frame.height / 6
    }
}
