import Vapor
import HTTP

final class ArtistController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Artist.all().makeNode())
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var artist = try request.artist()
        try artist.save()
        return artist
    }
    
    func show(request: Request, artist: Artist) throws -> ResponseRepresentable {
        return artist
    }
    
    func update(request: Request, artist: Artist) throws -> ResponseRepresentable {
        let new = try request.artist()
        var artist = artist
        artist.name = new.name
        try artist.save()
        return artist
    }
    
    func delete(request: Request, artist: Artist) throws -> ResponseRepresentable {
        try artist.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<Artist> {
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
    func artist() throws -> Artist {
        guard let json = json else { throw Abort.badRequest }
        return try Artist(node: json)
    }
}
