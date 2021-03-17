//
//  NoteDetailsViewController.swift
//  FocusStartTest
//
//  Created by Egor on 16.03.2021.
//

import UIKit
import CoreData

enum NoteDetailsState {
    case create, view, edit
}

class NoteDetailsViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var state: NoteDetailsState = .create
    var viewModel: NotesViewModel?
    var noteIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.textContainer.lineFragmentPadding = 0;
        configureViewState(to: state)
    }
    
    func configureViewState(to state: NoteDetailsState) {
        
        switch state {
        case .create:
            navigationBar.topItem?.title = "Add new note"
            actionButton.title = "Save"
            titleTextField.isEnabled = true
            textView.isEditable = true
        case .edit:
            navigationBar.topItem?.title = "Edit note"
            actionButton.title = "Save"
            titleTextField.isEnabled = true
            textView.isEditable = true
        case .view:
            navigationBar.topItem?.title = "Note"
            textView.text = viewModel?.notes[noteIndex].text
            titleTextField.text = viewModel?.notes[noteIndex].title
            actionButton.title = "Edit"
            titleTextField.isEnabled = false
            textView.isEditable = false
        }
        
        self.state = state
    }
    
    @IBAction func actionButtonTapped() {
        
        let title = titleTextField.text ?? "Empty"
        let text = textView.text ?? "Empty"
        
        switch state {
        case .create:
            viewModel?.addNewNote(title: title, text: text)
            performSegue(withIdentifier: "UpdateNotes", sender: self)
        case .edit:
            viewModel?.updateNote(noteIndex: noteIndex, title: title, text: text)
            performSegue(withIdentifier: "UpdateNotes", sender: self)
        case .view:
            configureViewState(to: .edit)
        }
        
    }
}
