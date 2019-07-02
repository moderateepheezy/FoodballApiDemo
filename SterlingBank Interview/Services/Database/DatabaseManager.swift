//
//  DatabaseManager.swift
//  Loystar
//
//  Created by SimpuMind on 2/19/19.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class DatabaseManager<T: Object> {
    
    static var helper: RealmHelper<T> {
        return RealmHelper<T>()
    }
    
    static func add(object: T) {
        DatabaseManager.helper.add(object: object)
    }
    
    static func add(objects: [T]) {
        DatabaseManager.helper.add(objects: objects)
    }
    
    static func update(object: T) {
        DatabaseManager.helper.update(object: object)
    }
    
    static func update(objects: [T]) {
        DatabaseManager.helper.update(objects: objects)
    }
    
    static func delete(taskID: Int) {
        
        guard let object = DatabaseManager.helper.findFirst(key: taskID as AnyObject) else {
            return
        }
        DatabaseManager.helper.delete(object: object)
    }
    
    static func deleteAll() {
        DatabaseManager.helper.deleteAll()
    }
    
    static func findFirst() -> T? {
        return DatabaseManager.helper.findFirst()
    }
    
    static func findByID(taskID: String) -> T? {
        guard let object = DatabaseManager.helper
            .findFirst(key: taskID as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findBy(key: String, value: AnyObject) -> [T] {
        return DatabaseManager.helper
            .findBy(key: key, value: value)
            .toArray(ofType: T.self) as [T]
    }
    
    static func findAll() -> [T] {
        return DatabaseManager.helper.findAll().toArray(ofType: T.self) as [T]
    }
}
