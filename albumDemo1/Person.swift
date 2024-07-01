//
//  Person.swift
//  albumDemo1
//
//  Created by Jay on 01/07/24.
//

import Foundation

class Person {
    
    var name: String = ""
    var age: Int = 0
    var id: Int = 0
    var imageUrl: String = ""
    
    init(name: String, age: Int, id: Int, imageUrl: String) {
        self.name = name
        self.age = age
        self.id = id
        self.imageUrl = imageUrl
    }
    
}
