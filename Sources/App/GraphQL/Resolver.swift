import Foundation
import Graphiti

/// This type contains methods that define how GraphQL responses are fetched
struct Resolver {
    
    // Todo
    
    func todos(ctx: Context, args: NoArguments) async throws -> [Todo] {
        return try await Todo.query(on: ctx.db).all()
    }
    
    func createTodo(ctx: Context, args: CreateTodo) async throws -> Todo {
        let todo = Todo(id: args.id, title: args.title)
        try await todo.create(on: ctx.db)
        return todo
    }
    
    func updateTodo(ctx: Context, args: UpdateTodo) async throws -> Todo {
        guard let todo = try await Todo.find(args.id, on: ctx.db) else {
            throw GraphQLError.idNotFound(args.id)
        }
        if let title = args.title {
            todo.title = title
        }
        try await todo.save(on: ctx.db)
        return todo
    }
    
    func deleteTodo(ctx: Context, args: DeleteTodo) async throws -> Todo {
        guard let todo = try await Todo.find(args.id, on: ctx.db) else {
            throw GraphQLError.idNotFound(args.id)
        }
        try await todo.delete(on: ctx.db)
        return todo
    }
}
