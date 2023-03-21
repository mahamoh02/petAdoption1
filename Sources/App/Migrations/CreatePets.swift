import Fluent
import Vapor
import FluentPostgresDriver
import Foundation
struct CreatePets: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("Pets")
            .id()
            .field("name", .string, .required)
            .field("gender", .string, .required)
            .field("age", .int, .required)
            .field("username", .string, .required)
            .field("contactnum", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("Pets").delete()
    }
}
