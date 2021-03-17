//
//  Note+CoreDataClass.swift
//  FocusStartTest
//
//  Created by Egor on 16.03.2021.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    func configureNote(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
