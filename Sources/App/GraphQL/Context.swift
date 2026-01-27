import Fluent

/// Contains objects that are available to every resolver. Instantiated on each query.
struct Context: Sendable {
    let db: Database
}
