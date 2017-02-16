# Vapor-Catalogue

Vapor-Catalogue is simple API for CD collection database. Project demonstrates basic concepts of backend development in Swift. 

`GET /albums` - all albums in database
`GET /album/:id` - get one album
`POST /albums` - create new album
`DELETE /album/:id` - delete album

`GET /artists` - all artists in database
`GET /artists/:id` - get one artist
`POST /artists` - create new artist
`DELETE /artists/:id` - delete artist

`GET /albums/:id/artists` - artist of particular album
`GET /artists/:id/albums` - albums of particular artist

`POST /auth/signup` - create user
`POST /auth/login` - login user

`GET user/albums` - get all albums of user
`POST user/album` - create album and assign it to the user

`GET artists/search?q=...` - search artist by name

Project implements basic secure user session based on JWT token.

