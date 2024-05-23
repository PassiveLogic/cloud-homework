import Fluent

/// Contains objects that are available to every resolver. Instantiated on each query.
struct Context {
    let db: Database
}
