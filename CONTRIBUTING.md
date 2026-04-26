# Contributing to Swift Dolibarr

Thank you for your interest in contributing to Swift Dolibarr! This document provides guidelines to help you get started.

## Reporting Bugs

If you find a bug, please [open an issue](https://github.com/m34dev/swiftdolibarr/issues/new) and include:

- A clear description of the problem
- Steps to reproduce the issue
- Expected vs. actual behavior
- The Dolibarr version you are working with
- The Swift and Xcode versions you are using

## Suggesting Features

For feature requests (e.g. support for a new Dolibarr object type), please open an issue first to discuss the idea before submitting code.

## Submitting Changes

1. Fork the repository
2. Create a branch from `main` (e.g. `feature/add-bank-account-model` or `fix/invoice-decoding`)
3. Make your changes
4. Ensure the project builds and any tests pass
5. Submit a merge request against `main`

## Code Style

This project uses [SwiftLint](https://github.com/realm/SwiftLint) to enforce code style. The linter runs automatically as a build plugin, so any violations will appear as warnings or errors during build.

General guidelines:

- Use **4-space indentation**
- Follow Swift naming conventions: `PascalCase` for types, `camelCase` for properties and methods
- Add doc comments for public API

## Adding a New Model

When adding support for a new Dolibarr object, follow the existing patterns:

1. Create a new folder under `Sources/SwiftDolibarr/Models/` for the module (if needed)
2. Inherit from the appropriate base class (`CommonBusinessObject`, `CommonCommercialTransactionObject`, etc.)
3. Implement `CodingKeys` mapping Dolibarr API field names to Swift property names
4. Implement `init(from:)`, `encode(to:)`, and `hash(into:)` following the same structure as existing models
5. Add statuses to `DolibarrObjectStatus` if the object has a status lifecycle
6. Add the new model to the supported objects table in `README.md`

## Scope

This package is a **data model layer only**. Contributions should focus on:

- New or updated Dolibarr object models
- Bug fixes in encoding/decoding
- Documentation improvements

Networking, authentication, and API client logic are out of scope for this package.

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE).
