import Auth
import Vapor
import VaporPostgreSQL
import VaporMemory

let drop = Droplet()

let auth = AuthMiddleware(user: User.self)
drop.middleware.append(auth)

try drop.addProvider(VaporPostgreSQL.Provider)
drop.preparations += Artist.self
drop.preparations += Album.self
drop.preparations += User.self

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

let users = UserController()
users.addRoutes(drop: drop)

let artists = ArtistController()
//drop.resource("artists", artists)
artists.addRoutes(drop: drop)

let albums = AlbumController()
//drop.resource("albums", albums)
albums.addRoutes(drop: drop)

drop.run()
