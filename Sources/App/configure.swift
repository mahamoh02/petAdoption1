import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
   

    if let urlString = Environment.get("DATABASE_URL"),
       var postgresConfig = PostgresConfiguration(url: urlString) {
        var tlsConfig = TLSConfiguration.makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        postgresConfig.tlsConfiguration = tlsConfig
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else{
        app.databases.use(.postgres(
            hostname:Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "mashaelalghunaim",
            password: Environment.get("DATABASE_PASSWORD") ?? "",
            database: Environment.get("DATABASE_NAME") ?? "newpetsadoption"
        ), as: .psql)
    }
   

    app.migrations.add(CreatePets())
    if app.environment == .development{
        try app.autoMigrate().wait()
    }
    
   

 
    let petsController = PetController()
    try app.register(collection: petsController)
//    app.http.server.configuration.port = Environment.get("PORT").flatMap(Int.init) ?? 8080

    // register routes
    try routes(app)
}
