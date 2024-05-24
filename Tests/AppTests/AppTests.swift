@testable import App
import XCTVapor
import Fluent
import GraphQL

final class AppTests: XCTestCase {
    var app: Application!
    
    override func setUp() async throws {
        self.app = try await Application.make(.testing)
        try await configure(app)
        try await app.autoMigrate()
    }
    
    override func tearDown() async throws { 
        try await app.autoRevert()
        try await self.app.asyncShutdown()
        self.app = nil
    }
    
    func testHelloWorld() async throws {
        try await self.app.test(.GET, "hello", afterResponse: { res async in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
    }

    func testGraphQLTodos() async throws {
        let testTodos = [Todo(title: "test1"), Todo(title: "test2")]
        try await testTodos.create(on: app.db)

        try await self.app.test(.POST, "graphql", beforeRequest: { req in
            try req.content.encode(
                GraphQLRequest(
                    query: """
                    {
                        todos {
                            title
                        }
                    }
                    """
                )
            )
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let result = try res.content.decode(GraphQLResult.self)
            XCTAssertEqual(
                result,
                GraphQLResult(
                    data: [
                        "todos": [
                            ["title": "test1"],
                            ["title": "test2"],
                        ]
                    ],
                    errors: []
                )
            )
        })
    }
}

extension GraphQLRequest: Content {}
