//
//  RealmHelper.swift
//  Loystar
//
//  Created by SimpuMind on 2/19/19.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class RealmHelper <T: Object> {
    let realm: Realm
    
    init() {
        try! realm = Realm()
        print(realm.configuration.fileURL?.absoluteString ?? "")
//        defer {
//            realm.invalidate()
//        }
    }
    
    // delete table
    func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    /**
     * New primary key issue
     */
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            // primaryKey not set
            return nil
        }
        
        let realm = try! Realm()
        return (realm.objects(T.self).max(ofProperty: key) as Int? ?? 0) + 1
    }
    
    /**
     * Find all Record
     */
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    
    /**
     * Fetch first item in the record
     */
    func findFirst() -> T? {
        return findAll().first
    }
    
    /**
     * Retrieve record of specified key
     */
    func findFirst(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    /**
     * Retrieve record of specified key
     */
    func findBy(key: String, value: AnyObject) -> Results<T> {
        return realm.objects(T.self).filter("\(key) == %@", value)
    }
    
    /**
     * Fetch last item in the record
     */
    func findLast() -> T? {
        return findAll().last
    }
    
    /**
     * Add to record
     */
    func add(object :T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /// Add mulitiple record
    ///
    /// - Parameter objects: Array of Record
    func add(objects: [T]) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /**
     * T: RealmSwift.Object Valid only when primaryKey () is implemented
     */
    @discardableResult
    func update(object: T, block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(object, update: .all)
            }
            return true
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
    
    @discardableResult
    func update(objects: [T], block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(objects, update: .all)
            }
            return true
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
    
    /**
     * Delete record
     */
    func delete(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /**
     * Delete all records
     */
    func deleteAll() {
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /**
     * Check if an object exist with id
    */
    func objectExist (id: String) -> Bool {
        
        return realm.object(ofType: T.self, forPrimaryKey: id) != nil
    }
}
