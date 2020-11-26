//
//  ClaimDAO.swift
//  RestfulServer
//
//  Created by RJ Andaya on 10/25/20.
//

import SQLite3
import Foundation

struct Claim: Codable{
    var id_: UUID?
    var title_: String
    var date_: String
    var isSolved_: Bool?
    
    init(this_id: UUID?, this_title: String, this_date: String, this_isSolved: Bool?) {
        id_ = this_id
        title_ = this_title
        date_ = this_date
        isSolved_ = this_isSolved
    }
    
    init(this_title: String, this_date: String) {
        title_ = this_title
        date_ = this_date
    }
}

class ClaimDAO {
    func addClaim(cObj: Claim) {
        let sqlStmt = String(format: "insert into claim (id, title, date, is_solved) values ('%@', '%@', '%@', '0')", UUID().uuidString, cObj.title_, cObj.date_)
//        Get database connection
        let conn = Database.getInstance().getDBConnection()
        
//        Submit the insert sql statement
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Failed to insert a Claim record due to error \(errcode)")
        }
//        Close connection
        sqlite3_close(conn)
    }

    func getAll() -> [Claim] {
        var cList = [Claim]()
        var resultSet: OpaquePointer?
        let sqlStr = "select id, title, date, is_solved from claim"
        let conn = Database.getInstance().getDBConnection()
        if sqlite3_prepare_v2(conn, sqlStr, -1, &resultSet, nil) == SQLITE_OK {
            while sqlite3_step(resultSet) == SQLITE_ROW {
//                Convert the record into a Claim object
//                Unsafe_Pointer<CChar> Sqlite3
                let id_val = sqlite3_column_text(resultSet, 0)
                let id = UUID(uuidString: String(cString: id_val!))
                let title_val = sqlite3_column_text(resultSet, 1)
                let title = String(cString: title_val!)
                let date_val = sqlite3_column_text(resultSet, 2)
                let date = String(cString: date_val!)
                let isSolved_val = sqlite3_column_text(resultSet, 3)
                let isSolved = Bool(exactly: (Int(String(cString: isSolved_val!)))! as NSNumber)
                cList.append(Claim(this_id: id, this_title: title, this_date: date, this_isSolved: isSolved))
            }
        }
        return cList
    }
}
