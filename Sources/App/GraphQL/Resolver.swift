import Graphiti

/// This type contains methods that define how GraphQL responses are fetched
struct Resolver {
    func hello(ctx: Context, args: NoArguments) -> String {
        return "world"
    }
}
