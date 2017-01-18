    //
//  Album.swift
//  Catalog
//
//  Created by Dan on 18.01.17.
//
//

import Foundation
import Vapor
import HTTP

final class Album: Model {

    var id: Node?
    var exists: Bool = false
    
    var title: String
    
    
    init(title: String) {
        self.id = nil
        self.title = title
    }
    
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
    }
    
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "title": title
            ])
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("albums") { albums in
            albums.id()
            albums.string("title")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("albums")
    }
    
}
