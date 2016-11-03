import Vapor
import Fluent
import Foundation

struct Todo: Model {
    var id: Node?
    
    var title: String?
    var completed: Bool?
    var order: Int?
    var created: Date?
    var period: Date?
    
    // used by fluent internally
    var exists: Bool = false
}

extension Todo: NodeConvertible {

    init(node: Node, in context: Context) throws {
        id        = try node.extract("id")
        title     = try node.extract("title")
        completed = try node.extract("completed")
        order     = try node.extract("order")
        
        // DoubleからDateに変換
        let createdDouble: Double? = try? node.extract("created")
        created = createdDouble != nil ? Date(timeIntervalSince1970: createdDouble!) : Date()
    }

    func makeNode(context: Context) throws -> Node {
        let complete = completed ?? false
        return try Node.init(node:
            [
                "id": id,
                "title": title,
                "completed": complete,
                "order": order,
                // DateからDoubleに変換
                "created": created?.timeIntervalSince1970
            ]
        )
    }
}

extension Todo: Preparation {
    static var databaseName: String { return "todos" }
    
    // データベース作成処理
    static func prepare(_ database: Database) throws {
        try database.create(databaseName, closure: { (todos) in
            todos.id()
            todos.string("title", length: 255, optional: true)
            todos.bool("completed")
            todos.int("order", optional: true)
            todos.double("created")
        })
    }

    // データベース作成のロールバック（削除）
    static func revert(_ database: Database) throws {
        try database.delete(databaseName)
    }
}

extension Todo: OrderSortable {}
