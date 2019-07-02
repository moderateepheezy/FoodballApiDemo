//
//  DatabaseLayerAPI.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

struct Sorted {
    var key: String
    var ascending: Bool = true
}

/*
 Operations on context
 */
protocol StorageContext {
    /*
     Create a new object with default values
     return an object that is conformed to the `Storable` protocol
     */
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save(object: Storable) throws
    /*
     Update an object that is conformed to the `Storable` protocol
     */
    func update(block: @escaping () -> ()) throws
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    func delete(object: Storable) throws
    /*
     Delete all objects that are conformed to the `Storable` protocol
     */
    func deleteAll<T: Storable>(_ model: T.Type) throws
    /*
     Return a list of objects that are conformed to the `Storable` protocol
     */
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
}
