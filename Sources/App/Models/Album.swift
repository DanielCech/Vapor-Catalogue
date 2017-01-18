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
    var artistId: Node?
    
    
    init(title: String, artistId: Node? = nil) {
        self.id = nil
        self.title = title
        self.artistId = artistId
    }
    
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
        artistId = try node.extract("artist_id")
    }
    
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "title": title,
            "artist_id": artistId
            ])
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("albums") { albums in
            albums.id()
            albums.string("title")
            albums.parent(Artist.self, optional: false)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("albums")
    }
    
}
    
extension Album {
    func artist() throws -> Artist? {
        return try parent(artistId, nil, Artist.self).get()
    }
}
