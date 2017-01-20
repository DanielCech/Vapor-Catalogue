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
            
            users.post { req in
                guard let name = req.data["name"]?.string else {
                    throw Abort.badRequest
                }
                
                var user = User(name: name)
                try user.save()
                return user
            }
            
            users.post("login") { req in
                guard let id = req.data["id"]?.string else {
                    throw Abort.badRequest
                }
                
                let creds = try Identifier(id: id)
                try req.auth.login(creds)
                
                return try JSON(node: ["message": "Logged in via default, check vapor-auth cookie."])
            }
            
            let protect = ProtectMiddleware(error:
                Abort.custom(status: .forbidden, message: "Not authorized.")
            )
            users.group(protect) { secure in
                secure.get("secure") { req in
                    return try req.user()
                }
            }
            
            users.get(User.self, "albums", handler: albumsIndex)
        }
    }
    
    
    func albumsIndex(request: Request, user: User) throws -> ResponseRepresentable {
        let children = try user.albums()
        return try JSON(node: children.makeNode())
    }
}
