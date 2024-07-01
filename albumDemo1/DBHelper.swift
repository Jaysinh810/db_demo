//
//  DBHelper.swift
//  albumDemo1
//
//  Created by Jay on 01/07/24.
//

import Foundation
import SQLite3

class DBHelper {
    
    init() {
        db = openDatabase()
        createTable()
        
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    //MARK: ------------------------- OPEN DATABASE -------------------------
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening databasse")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    //MARK: ------------------------- CREATE TABLE -------------------------
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY, name TEXT,age INTEGER, imageUrl STRING);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    //MARK: ------------------------- INSERT DATA -------------------------
    
    func insert(id:Int, name:String, age:Int, imageUrl:String) {
        let persons = read()
        
        for p in persons {
            if p.id == id {
                return
            }
        }
        let insertStatementstring = "INSERT INTO person (Id, name, age, imageUrl) VALUES (?, ?, ?, ?);"
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementstring, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            sqlite3_bind_text(insertStatement, 4, (imageUrl as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    //MARK: ------------------------- READ DATA -------------------------
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let year = sqlite3_column_int(queryStatement, 2)
                let imageUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                psns.append(Person(name: name, age: Int(year), id: Int(id), imageUrl: imageUrl))
                print("Query Result:")
                print("\(id) | \(name) | \(year) | \(imageUrl)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
    //MARK: ------------------------- DELETE DATA -------------------------
    
    func deletebyID(id: Int) {
        let deleteStatementString = "DELETE FROM person WHERE Id = ?;"
        var deleteStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
    
    
}

