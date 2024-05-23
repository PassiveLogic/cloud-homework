# PassiveLogic Cloud Take Home Assignment

This repository contains a basic Vapor GraphQL API project.

You will be invited to a private fork of this repo. Please write your code in a feature branch, and create a pull request when you're finished.

> If you would like to avoid showing this work publicly, disable "Include private contributions on my profile" under "Contributions" in your profile settings.

## Getting Started

It is recommended that you complete this using a Linux or MacOS environment. While you can use any development environment you like, XCode (MacOS only) or VSCode using the [Swift extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) seem to have the best Swift support.

1. [Install a Swift toolchain](https://www.swift.org/install/)
1. Clone this repository
1. Start the database: `docker compose up db -d`
1. Build the package: `swift build`
1. Run the migration: `swift run App migrate`
1. Run the executable: `swift run App serve --hostname 0.0.0.0 --port 8080`