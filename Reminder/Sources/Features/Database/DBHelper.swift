//
//  DBHelper.swift
//  Reminder
//
//  Created by Lucas Rosa  on 20/02/25.
//

import Foundation
import SQLite3 // usando o import do 3, por que ele já vem nativamente.

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?

    private init() {
        openDatabase()
        createTable()
    }

    private func openDatabase() {
        let fileUrl = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Reminder.sqlite")

        if sqlite3_open(fileUrl.path, &db)  != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
        }
    }
    private func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Receipts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            remedy TEXT,
            time TEXT,
            recurrency TEXT,
            takeNow INTEGER
        );
        """

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabela criada com sucesso")
            } else {
                print("Erro na criação da tabela")
            }
        } else {
            print("CreateTable statement não conseguiu executar")
        }

        sqlite3_finalize(statement)

    }

    func insertReceipt(remedy: String, time: String, recurrency: String, takeNow: Bool) {
        let insertQuery = "INSERT INTO Receipts (remedy, time, recurrency, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrency as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita inserida com sucesso.")
            } else {
                let errMessage = String(cString: sqlite3_errmsg(db)!)
                print(errMessage)
                print("Falha ao inserir receita na tabela")
            }
        } else {
            print("INSERT statement falhou")
        }

        sqlite3_finalize(statement)

    }

    func fetchReceipts() -> [Medicine] {
        let fetchQuery = "SELECT * FROM Receipts"
        var statement: OpaquePointer?
        var receipts: [Medicine] = []

        if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy =  sqlite3_column_text(statement, 1).flatMap { String(cString: $0)} ?? "Unknown"
                let time =  sqlite3_column_text(statement, 2).flatMap { String(cString: $0)} ?? "Unknown"
                let recurrency = sqlite3_column_text(statement, 3).flatMap { String(cString: $0)} ?? "Unknown"

                receipts.append(Medicine(id: id, remedy: remedy, time: time, recurrency: recurrency))
            }
        } else {
            print("SELECT statement falhou")
        }

        sqlite3_finalize(statement)

        return receipts

    }

    func deleteReceipt(byId id: Int) {
        let deleteQuery = "DELETE FROM Receipts WHERE id = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))

            if sqlite3_step(statement) == SQLITE_DONE {
                print("receita deletada")
            } else {
                print("Error ao deletar a receita")
            }
        } else {
            print("Delete statement falhou")
        }

        sqlite3_finalize(statement)
    }
}
