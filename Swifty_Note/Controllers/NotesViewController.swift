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
class NotesViewController: UIViewController {
    @IBOutlet weak var notesTableView: UITableView!
    var notes : [Note] = [Note]()
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.register(UINib(nibName: "noteTableViewCell", bundle: nil), forCellReuseIdentifier: "noteCell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
    }
    
    func getNotes() {
        let realm = try! Realm()
        notes = Array( realm.objects(Note.self))
        notesTableView.reloadData()
    }
}
extension NotesViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesTableView.isHidden = notes.isEmpty
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! noteTableViewCell
        cell.descriptionTxt.text = notes[indexPath.row].noteDescription
        let image = ImageSaver.fetchImage(imageName: notes[indexPath.row].noteImage ?? "")
        cell.noteImage.image = image
        cell.noteNumberTxt.text = notes[indexPath.row].noteTitle
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(notes[indexPath.row])
        }
        notes.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addNoteViewController.editedNote = notes[indexPath.row]
        performSegue(withIdentifier: "addNoteSegue", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 6
    }
}
