//
//  NotesViewController.swift
//  FocusStartTest
//
//  Created by Egor on 15.03.2021.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties

    var viewModel: NotesViewModel
    
    
    //MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        viewModel = NotesViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewModel.updateUI = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        
        viewModel = NotesViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        super.init(coder: coder)
        
        viewModel.updateUI = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func updateNotesSegue( _ seg: UIStoryboardSegue) {
        // unwind segue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! NoteDetailsViewController
        destVC.viewModel = viewModel
        
        if let index = sender as? Int {
            destVC.noteIndex = index
            destVC.state = .view
        }
    }
}

// MARK: - Extensions

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "NoteDetails", sender: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)

        cell.textLabel?.text = viewModel.notes[indexPath.row].title
        cell.detailTextLabel?.text = viewModel.notes[indexPath.row].text

        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.deleteNoteAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


extension NotesViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
}
