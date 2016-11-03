import Vapor
import VaporMySQL

let drop = Droplet(
    preparations: [Todo.self],
    providers: [VaporMySQL.Provider.self]
)

drop.get { req in
    let lang = req.headers["Accept-Language"]?.string ?? "en"
    return try drop.view.make("welcome", [
    	"message": Node.string(drop.localization[lang, "welcome", "title"])
    ])
}

drop.resource("todos", TodoController())

drop.run()
