import Graphiti

func graphqlSchema() throws -> Schema<Resolver, Context> {
    return try Schema<Resolver, Context> {
        Query {
            Field("hello", at: Resolver.hello)
        }
    }
}
