import PackageDescription

let package = Package(
    name: "Catalog",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3),
        .Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 0),
        .Package(url: "https://github.com/sfaxon/vapor-memory-provider.git", majorVersion: 1),
        .Package(url: "https://github.com/siemensikkema/vapor-jwt.git", majorVersion: 0),
        .Package(url: "https://github.com/siemensikkema/Punctual.swift.git", majorVersion: 2),
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

