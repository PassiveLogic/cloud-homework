import Fluent
import GraphQL
import Graphiti
import GraphQLVapor
import Vapor

func routes(_ app: Application) throws {

    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let graphqlSchema = try graphqlSchema()
    app.graphql(
        schema: graphqlSchema.schema,
        rootValue: Resolver(),
        config: .init(allowMissingAcceptHeader: true)
    ) { req in
        Context(db: req.db)
    }
}
