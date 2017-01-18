import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider)
drop.preparations += Artist.self
drop.preparations += Album.self

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

let artists = ArtistController()
drop.resource("artists", artists)

let albums = AlbumController()
drop.resource("albums", albums)

drop.run()
