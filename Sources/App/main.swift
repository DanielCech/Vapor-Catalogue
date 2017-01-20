import Auth
import Vapor
import VaporPostgreSQL
import VaporMemory
import Vapor

let drop = Droplet()

private let jwtKey = try drop.config.data(for: AppKey.jwt)!.makeBytes()

drop.middleware.append(AuthMiddleware<User>())
drop.middleware.append(JWTMiddleware(jwtKey: jwtKey))

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

private let authController = AuthController(jwtKey: jwtKey, hash: drop.hash)
drop.group("auth") {
    $0.post("update_password", handler: authController.updatePassword)
    $0.post("log_in", handler: authController.logIn)
    $0.post("sign_up", handler: authController.signUp)
}

let protect = ProtectMiddleware(error:
    Abort.custom(status: .forbidden, message: "Not authorized.")
)

drop.run()
