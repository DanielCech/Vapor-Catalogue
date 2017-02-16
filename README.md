# Vapor-Catalogue

Vapor-Catalogue is simple API for CD collection database. I learned on this project the basic concepts of backend development in Swift. Fun part is related to user session based on JWT token.

**Albums**
* `GET /albums` - all albums in database
* `GET /album/:id` - get one album
* `POST /albums` - create new album
* `DELETE /album/:id` - delete album

**Artists**
* `GET /artists` - all artists in database
* `GET /artists/:id` - get one artist
* `POST /artists` - create new artist
* `DELETE /artists/:id` - delete artist

**Additional**
* `GET /albums/:id/artists` - artist of particular album
* `GET /artists/:id/albums` - albums of particular artist

**User management**
* `POST /auth/signup` - create user
* `POST /auth/login` - login user
* `GET user/albums` - get all albums of user
* `POST user/album` - create album and assign it to the user

* `GET artists/search?q=...` - search artist by name
