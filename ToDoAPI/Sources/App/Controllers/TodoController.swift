import Vapor
import HTTP
import Foundation

final class TodoController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try Todo.all().makeNode().converted(to: JSON.self)
    }

    func create(request: Request) throws -> ResponseRepresentable {
        var todo = try request.post()
        todo.created = Date()
        todo.order = try Todo.all().filter({ !($0.completed ?? false) }).count + 1
        try todo.save()
        return todo
    }

    func show(request: Request, todo: Todo) throws -> ResponseRepresentable {
        return todo
    }

    func delete(request: Request, todo: Todo) throws -> ResponseRepresentable {
        try todo.delete()
        return JSON([:])
    }

    func clear(request: Request) throws -> ResponseRepresentable {
        try Todo.query().delete()
        return JSON([])
    }

    func update(request: Request, todo: Todo) throws -> ResponseRepresentable {
        let new = try request.post()
        var todo = todo
        todo.title = new.title
        try todo.save()
        return todo
    }

    func replace(request: Request, todo: Todo) throws -> ResponseRepresentable {
        try todo.delete()
        return try create(request: request)
    }

    func makeResource() -> Resource<Todo> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func post() throws -> Todo {
        guard let json = json else {
            throw Abort.badRequest
        }
        return try Todo(node: json)
    }
}
