import Foundation

struct CreateTodo: Codable {
    let id: UUID?
    let title: String
}

struct UpdateTodo: Codable {
    let id: UUID
    let title: String?
}

struct DeleteTodo: Codable {
    let id: UUID
}
