import Fluent
import Vapor

struct PetController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let pets = routes.grouped("Pets")
        pets.get(use: index)
        pets.post(use: create)
        pets.group(":PetsID") { p in
            p.delete(use: delete)
        }
        
    }
    
    func index(req: Request) async throws -> [Petmodel] {
        try await Petmodel.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Petmodel {
        let newpetsadoption = try req.content.decode(Petmodel.self)
        try await newpetsadoption.save(on: req.db)
        return newpetsadoption
    }
    
  
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {

                  let pets = try req.content.decode(Petmodel.self)

                  return Petmodel.find(pets.id, on: req.db)
                      .unwrap(or: Abort(.notFound))
                      .flatMap {
                          $0.name = pets.name
                          $0.gender = pets.gender
                          
                          return $0.update(on: req.db).transform(to: .ok)
                      }
      }


    func delete(req:Request)  throws -> EventLoopFuture<HTTPStatus> {
        Petmodel.find(req.parameters.get("PetsID"), on: req.db).unwrap(or: Abort(.notFound))
                    .flatMap {
                        $0.delete(on: req.db)
                    }.transform(to: .ok)
    }
    }
    

