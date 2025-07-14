@testable import App
import XCTVapor
import Fluent
@preconcurrency import GraphQL

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

    func testGraphQLCreateTodo() async throws {
        var id: UUID? = nil
        try await self.app.test(.POST, "graphql", beforeRequest: { req in
            try req.content.encode(
                GraphQLRequest(
                    query: """
                    mutation {
                        createTodo(title: "test1") {
                            id
                        }
                    }
                    """
                )
            )
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let result = try res.content.decode(GraphQLResult.self)
            let idString = try XCTUnwrap(result.data?["createTodo"].dictionary?["id"]?.string)
            id = try XCTUnwrap(UUID(uuidString: idString))
        })

        let todoOptional = try await Todo.find(XCTUnwrap(id), on: app.db)
        let todo = try XCTUnwrap(todoOptional)
        XCTAssertEqual(todo.title, "test1")
    }

    func testGraphQLUpdateTodo() async throws {
        let todo = Todo(title: "test1")
        try await todo.create(on: app.db)

        try await self.app.test(.POST, "graphql", beforeRequest: { req in
            try req.content.encode(
                GraphQLRequest(
                    query: """
                    mutation {
                        updateTodo(id: "\(XCTUnwrap(todo.id))", title: "test2") {
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
                        "updateTodo": [
                            "title": "test2",
                        ]
                    ],
                    errors: []
                )
            )
        })
    }

    func testGraphQLDeleteTodo() async throws {
        let todo = Todo(title: "test1")
        try await todo.create(on: app.db)

        try await self.app.test(.POST, "graphql", beforeRequest: { req in
            try req.content.encode(
                GraphQLRequest(
                    query: """
                    mutation {
                        deleteTodo(id: "\(XCTUnwrap(todo.id))") {
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
                        "deleteTodo": [
                            "title": "test1",
                        ]
                    ],
                    errors: []
                )
            )
        })

        let todoOptional = try await Todo.find(XCTUnwrap(todo.id), on: app.db)
        XCTAssertNil(todoOptional)
    }
}
