import Vapor
import HTTP

final class AlbumController: ResourceRepresentable {
    
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
    
    func makeResource() -> Resource<Album> {
        return Resource(
            index: index,
            store: create,
            show: show,
            modify: update,
            destroy: delete
        )
    }
    
}

extension Request {
    func album() throws -> Album {
        guard let json = json else { throw Abort.badRequest }
        return try Album(node: json)
    }
}
