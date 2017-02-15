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
        let group = drop.grouped("user")
        
        let albumGroup = group.grouped("albums")
        
        albumGroup.get(handler: index)
        albumGroup.post(handler: create)
//        group.get(Album.self, handler: show)
//        group.patch(Album.self, handler: update)
//        group.delete(Album.self, handler: delete)
//        group.get(Album.self, "artists", handler: artistShow)
        
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let userID = try User.getUserIDFromAuthorizationHeader(request: request)
        let user = try User.find(userID)
        return try JSON(node: user?.albums().makeNode())
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        let userID = try User.getUserIDFromAuthorizationHeader(request: request)
        var album = try request.album()
        album.userId = Node(userID)
        try album.save()
        return album
    }
    
    
    func albumsIndex(request: Request, user: User) throws -> ResponseRepresentable {
        let children = user.albums()
        return try JSON(node: children.makeNode())
    }
}
