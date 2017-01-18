//
//  Artist.swift
//  Catalog
//
//  Created by Dan on 18.01.17.
//
//

import Foundation
import Vapor
import HTTP

final class Artist: Model {
    
    var id: Node?
    var exists: Bool = false
    
    var name: String
    
    
    init(name: String) {
        self.id = nil
        self.name = name
    }
    
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
    }
    
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name
            ])
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("artists") { artists in
            artists.id()
            artists.string("name")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("artists")
    }
    
}
