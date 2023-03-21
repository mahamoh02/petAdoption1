import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname:"localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: "mashaelalghunaim",
        password: "",
        database: "newpetsadoption"
    ), as: .psql)

    app.migrations.add(CreatePets())
    // Import your BooksController at the top of the file
   

    // Inside the configure() function, register your BooksController
    let petsController = PetController()
    try app.register(collection: petsController)
    app.http.server.configuration.port = Environment.get("PORT").flatMap(Int.init) ?? 8080

    // register routes
    try routes(app)
}
