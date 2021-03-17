//
//  NotesViewModel.swift
//  FocusStartTest
//
//  Created by Egor on 16.03.2021.
//

import Foundation
import CoreData

class NotesViewModel {
    
    var context: NSManagedObjectContext
    var notes: [Note] = []
    var updateUI: (() -> Void)?
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchNotes()
        if notes.count == 0 {
            let note = Note(context: context)
            note.title = "Стартовая заметка"
            note.text = """
                - Кликните на заметку, чтобы просмотреть ее полностью
                - Нажмите edit, чтобы редактировать заметку
                - Нажмите save, чтобы сохранить изменения
                - Чтобы удалить заметку, на стартовом экране сделайте свайп справа по заметке и нажмите кнопку Delete
                """
            updateContext()
        }
    }
    
    func fetchNotes() {
        
        do {
            self.notes = try context.fetch(Note.fetchRequest())
            updateUI?()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateContext() {
        
        do {
            try self.context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        self.fetchNotes()
        
        updateUI?()
    }
    
    func addNewNote(title: String, text: String) {
        
        let note = Note(context: context)
        note.configureNote(title: title, text: text)
        notes.append(note)
        updateContext()
        updateUI?()
    }
    
    func deleteNoteAt(index: Int) {
        
        let note = notes[index]
        context.delete(note)
        updateContext()
        updateUI?()
    }
    
    func updateNote(noteIndex: Int, title: String, text: String) {
        
        notes[noteIndex].configureNote(title: title, text: text)
        updateContext()
        updateUI?()
    }
}
