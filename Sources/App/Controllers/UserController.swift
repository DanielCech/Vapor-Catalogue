//
//  UserController.swift
//  Catalog
//
//  Created by Dan on 19.01.17.
//
//

import Vapor
import HTTP
import Auth

final class UserController {
    
    func addRoutes(drop: Droplet) {
        drop.group("users") { users in
            users.get(User.self, "albums", handler: albumsIndex)
        }
    }
    
    
    func albumsIndex(request: Request, user: User) throws -> ResponseRepresentable {
        let children = user.albums()
        return try JSON(node: children.makeNode())
    }
}
