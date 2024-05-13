import Foundation

struct ToDoModel: Identifiable, Encodable, Decodable {
    let id: UUID
    let description: String
    let createAt: Date
}
