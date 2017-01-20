import Vapor
import HTTP

final class AlbumController {
    
    func addRoutes(drop: Droplet) {
        let group = drop.grouped("albums")
        
        group.get(handler: index)
        group.post(handler: create)
        group.get(Album.self, handler: show)
        group.patch(Album.self, handler: update)
        group.delete(Album.self, handler: delete)
        group.get(Album.self, "artists", handler: artistShow)
        
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Album.all().makeNode())
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var album = try request.album()
        try album.save()
        return album
    }
    
    func show(request: Request, album: Album) throws -> ResponseRepresentable {
        return album
    }
    
    func update(request: Request, album: Album) throws -> ResponseRepresentable {
        let new = try request.album()
        var album = album
        album.title = new.title
        try album.save()
        return album
    }
    
    func delete(request: Request, album: Album) throws -> ResponseRepresentable {
        try album.delete()
        return JSON([:])
    }
    
//    func makeResource() -> Resource<Album> {
//        return Resource(
//            index: index,
//            store: create,
//            show: show,
//            modify: update,
//            destroy: delete
//        )
//    }
    
    func artistShow(request: Request, album: Album) throws -> ResponseRepresentable {
        let artist = try album.artist()
        return try JSON(node: artist?.makeNode())
    }
    
}

extension Request {
    func album() throws -> Album {
        guard let json = json else { throw Abort.badRequest }
        return try Album(node: json)
    }
}
