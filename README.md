# PassiveLogic Cloud Take Home Assignment

This assignment involves creating the backend for a Todo list application. The provided repository serves as a starting point, and your task is to add several new features. It includes a Vapor server and a small GraphQL API for managing todo list items, all supported by a PostgreSQL database.

You will be invited to a private fork of this repo. Please create a branch, complete the objectives below, and add a document at the repo root explaining what you've done. Feel free to list any assumptions, reasoning, or architecture in that document. When you're finished, create a pull request.

> If you would like to avoid showing this work publicly, disable "Include private contributions on my profile" under "Contributions" in your profile settings.

## Getting Started

It is recommended that you complete this using a Linux or MacOS environment. While you can use any development environment you like, XCode (MacOS only) or VSCode using the [Swift extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) generally have the best Swift support.

> If you only have access to a Windows environment, you can use a VSCode [Dev Container](https://code.visualstudio.com/docs/devcontainers/containers) to complete the assignment. To get set up, install the [Dev Containers VSCode Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers), go to the `Remote Explorer` menu, and click `Start in Dev Container`. This will start up a Docker image with the Swift toolchain and a running database.

1. Ensure you have [Docker installed](https://www.docker.com/products/docker-desktop/)
1. Clone this repository
1. [Install a Swift toolchain](https://www.swift.org/install/) (skip if using VSCode Dev Container)
1. Start the database (skip if using VSCode Dev Container): `docker compose up db -d`
1. Build the package: `swift build`
1. Set up the database: `swift run App migrate`
1. Run the server: `swift run App serve --hostname 0.0.0.0 --port 8080`
1. Visit the GraphiQL page: http://localhost:8080/graphql

## Objectives

1. Allow Todo items to be completed
    - Completion and uncompletion state should be controlled by separate mutations (not `updateTodo`)
    - The `todos` query should allow filtering for completed or uncompleted items
2. Add pagination to the `todos` query
    - Also add a query that returns the total number of todo items
3. Add a `TodoList` type that collects multiple Todo items
    - Todo lists should be able to be created, queried, updated, and deleted
    - All Todo items should belong to a list
    - Todo items should only belong to one list at a time, but may be moved from list to list
    - Add the ability to get all todo items for a given list through a GraphQL object traversal

## Resources

- Swift: https://docs.swift.org/swift-book/documentation/the-swift-programming-language
- Vapor: https://docs.vapor.codes/
- GraphQL: https://graphql.org/learn/
- Graphiti: https://github.com/GraphQLSwift/Graphiti/blob/main/UsageGuide.md
