import Vapor
import HTTP

final class ArtistController {
    
    func addRoutes(drop: Droplet) {
        let group = drop.grouped("artists")
        
        group.get(handler: index)
        group.post(handler: create)
        group.get(Artist.self, handler: show)
        group.patch(Artist.self, handler: update)
        group.delete(Artist.self, handler: delete)
        group.get(Artist.self, "albums", handler: albumsIndex)
        
        let searchGroup = group.grouped("search")
        searchGroup.get(handler: search)
        
    }
    
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
    
//    func makeResource() -> Resource<Artist> {
//        return Resource(
//            index: index,
//            store: create,
//            show: show,
//            modify: update,
//            destroy: delete
//        )
//    }
    
    
    func albumsIndex(request: Request, artist: Artist) throws -> ResponseRepresentable {
        let children = try artist.albums()
        return try JSON(node: children.makeNode())
    }
    
    
    func search(request: Request) throws -> ResponseRepresentable {
        let results: Node
        
        if let searchQuery = request.query?["q"]?.string {
            results = try Artist.query().filter("name", .contains, searchQuery).all().makeNode()
        }
        else {
            results = []
        }
        
        if request.accept.prefers("html") {
            let parameters = try Node(node: [
                "searchResults": results,
                ])
            return try drop.view.make("index", parameters)
        } else {
            return JSON(results)
        }
    }
}

extension Request {
    func artist() throws -> Artist {
        guard let json = json else { throw Abort.badRequest }
        return try Artist(node: json)
    }
}
