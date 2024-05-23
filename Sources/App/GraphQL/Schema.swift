import Foundation
import Graphiti

func graphqlSchema() throws -> Schema<Resolver, Context> {
    return try Schema<Resolver, Context> {
        Scalar(UUID.self)
        
        Type(Todo.self) {
            Field("id", at: \.id)
            Field("title", at: \.title)
        }
        
        Query {
            Field("todos", at: Resolver.todos)
        }
        
        Mutation {
            Field("createTodo", at: Resolver.createTodo) {
                Argument("id", at: \.id)
                Argument("title", at: \.title)
            }
            Field("updateTodo", at: Resolver.updateTodo) {
                Argument("id", at: \.id)
                Argument("title", at: \.title)
            }
            Field("deleteTodo", at: Resolver.deleteTodo) {
                Argument("id", at: \.id)
            }
        }
    }
}
