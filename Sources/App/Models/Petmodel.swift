import Fluent
import Vapor

final class Petmodel: Model, Content {
    static let schema = "Pets"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "gender")
    var gender: String
    
    @Field(key: "age")
    var age: Int
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "contactnum")
    var contactnum: Int

    init() { }

    init(id: UUID? = nil, name: String,gender: String,age: Int,username: String,contnum: Int) {
        self.id = id
        self.name = name
        self.gender = gender
        self.age = age
        self.username = username
        self.contactnum = contactnum
    }
}
