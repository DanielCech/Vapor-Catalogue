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
    var userId: Node?
    
    
    init(title: String, artistId: Node? = nil, userId: Node? = nil) {
        self.id = nil
        self.title = title
        self.artistId = artistId
        self.userId = userId
    }
    
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
        artistId = try node.extract("artist_id")
        userId = try node.extract("user_id")
    }
    
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "title": title,
            "artist_id": artistId,
            "user_id": userId,
            ])
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("albums") { albums in
            albums.id()
            albums.string("title")
            albums.parent(Artist.self, optional: false)
            albums.parent(User.self, optional: false)
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
    
    func user() throws -> User? {
        return try parent(userId, nil, User.self).get()
    }
}
