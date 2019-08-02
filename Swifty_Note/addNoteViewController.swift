//
//  addNoteViewController.swift
//  Swifty_Note
//
//  Created by user on 8/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
class addNoteViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var note_imageView: UIImageView!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    static var editedNote : note?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let edited = addNoteViewController.editedNote{
            self.descriptionTxt.text = edited.noteDescription
            self.note_imageView.image = imageSaver.fetchImage(imageName: edited.noteImage ?? "")
            self.titleTxt.text = edited.noteTitle
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    @IBAction func getImagesFromCam(_ sender: Any) {
        presentImagePicker(type: .camera)
    }
    @IBAction func getImageFromImages(_ sender: Any) {
        presentImagePicker(type: .photoLibrary)
    }
    @IBAction func returnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func savePressed(_ sender: Any)
    {
        self.save()
    }
    func save()
    {
        if let title = titleTxt.text , let descrpition = descriptionTxt.text
        {
            if !title.isEmpty && !descrpition.isEmpty
            {
              
                let noteObject = note()
                noteObject.noteDescription = descrpition
                let image_name = imageSaver.saveImage(imageObject: note_imageView.image)
                noteObject.noteImage = image_name
                noteObject.noteTitle = title
                let realm = try! Realm()
                if let edited = addNoteViewController.editedNote{
                    try! realm.write {
                        realm.delete(edited)
                    }
                }
                try! realm.write {
                    realm.add(noteObject)
                }
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        let alert = UIAlertController(title: "Complete All fields", message: "Add title and description for the note", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert , animated: true)
        
        }
        func presentImagePicker(type : UIImagePickerController.SourceType){
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = type
            picker.delegate = self
            self.present(picker ,animated: true)
        }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addNoteViewController.editedNote = nil
    }
    
}




