# PassiveLogic Cloud Take Home Assignment

This repository contains a basic Vapor GraphQL API project.

You will be invited to a private fork of this repo. Please create a branch, complete the objectives below, and add a document at the repo root explaining what you've done. Feel free to list any assumptions, reasoning, or architecture in that document. When you're finished, create a pull request.

> If you would like to avoid showing this work publicly, disable "Include private contributions on my profile" under "Contributions" in your profile settings.

## Getting Started

It is recommended that you complete this using a Linux or MacOS environment. While you can use any development environment you like, XCode (MacOS only) or VSCode using the [Swift extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) seem to have the best Swift support.

1. [Install a Swift toolchain](https://www.swift.org/install/)
1. Clone this repository
1. Start the database: `docker compose up db -d`
1. Build the package: `swift build`
1. Set up the database: `swift run App migrate`
1. Run the server: `swift run App serve --hostname 0.0.0.0 --port 8080`
1. Visit the GraphiQL page: http://localhost:8080/graphql


## Objectives

1. Allow Todo items to be completed.
    - Completion and uncompletion state should be controlled by separate mutations (not `updateTodo`)
    - Newly created items must always be uncompleted
    - The `todos` query should allow filtering for completed or uncompleted items
3. Add pagination to the `todo` query.
    - Include a "page number" and a "number of items per page" arguments
    - Add a query that returns the total number of todo items.
2. Add a `TodoList` type that collects multiple Todo items.
    - Todo lists should have an `id` and `name` field
    - Add this type via a migration
    - Add Todo list queries and mutations to GraphQL
    - Add the ability to get all

## Resources

- Swift: https://docs.swift.org/swift-book/documentation/the-swift-programming-language
- Vapor: https://docs.vapor.codes/
- GraphQL: https://graphql.org/learn/
- Graphiti: https://github.com/GraphQLSwift/Graphiti/blob/main/UsageGuide.md
