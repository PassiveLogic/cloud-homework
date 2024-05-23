import Foundation

enum GraphQLError: Error {
    case idNotFound(UUID)
}
