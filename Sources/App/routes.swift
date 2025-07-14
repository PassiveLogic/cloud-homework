import Fluent
@preconcurrency import GraphQL
@preconcurrency import Graphiti
import Vapor

func routes(_ app: Application) throws {

    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("graphql") { req in
        return try await req.view.render("graphiql")
    }

    let graphqlSchema = try graphqlSchema()
    app.post("graphql") { req in
        let graphqlRequest = try req.content.decode(GraphQLRequest.self)
        return try await graphqlSchema.execute(
            request: graphqlRequest.query,
            resolver: Resolver(),
            context: .init(db: req.db),
            eventLoopGroup: req.eventLoop,
            variables: graphqlRequest.variables,
            operationName: graphqlRequest.operationName
        ).get()
    }
}

extension GraphQLRequest: @retroactive Content, @unchecked Sendable {}
extension GraphQLResult: @retroactive Content, @unchecked Sendable {}
