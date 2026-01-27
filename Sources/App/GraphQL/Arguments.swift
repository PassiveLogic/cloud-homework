import Foundation

struct CreateTodo: Codable, Sendable {
    let id: UUID?
    let title: String
}

struct UpdateTodo: Codable, Sendable {
    let id: UUID
    let title: String?
}

struct DeleteTodo: Codable, Sendable {
    let id: UUID
}
