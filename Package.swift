// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LumiKitMarkdown",
    defaultLocalization: "en",
    platforms: [
        .macOS("14.0"),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "KitMarkdownCore",
            targets: ["KitMarkdownCore"]
        ),
        .library(
            name: "KitMarkdown",
            targets: ["KitMarkdown"]
        ),
        .library(
            name: "KitMarkdownTesting",
            targets: ["KitMarkdownTesting"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/lumi-softworks/LumiKitTreeSitterGrammars.git", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.9.0"),
        .package(url: "https://github.com/lukilabs/beautiful-mermaid-swift", from: "1.0.4"),
        .package(url: "https://github.com/lumi-softworks/LumiLocalization.git", from: "1.0.2"),
        .package(url: "https://github.com/lumi-softworks/LumiUI.git", from: "1.18.1"),
        // 代码块语法高亮：tree-sitter 运行时与内置语法。
        // 版本约束与 PluginCodeEditorLanguages 保持一致，保证解析结果一致。
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter.git", from: "0.25.0"),
        .package(
            url: "https://github.com/alex-pinkus/tree-sitter-swift.git",
            exact: "0.7.3-with-generated-files"
        ),
        .package(
            url: "https://github.com/tree-sitter/tree-sitter-typescript.git",
            exact: "0.23.2"
        ),
        .package(url: "https://github.com/tree-sitter/tree-sitter-json.git", exact: "0.24.8"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-bash.git", exact: "0.25.1"),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-markdown.git", exact: "0.5.4"),
    ],
    targets: [
        .target(
            name: "KitMarkdownCore",
            dependencies: [
                .product(name: "Markdown", package: "swift-markdown"),
                .product(name: "LumiLocalizationKit", package: "LumiLocalization"),
            ],
            path: ".",
            exclude: [
                "Package.swift",
                "Mermaid",
                "Highlighting",
                "README.md",
                "Resources",
                "docs",
                "Tests",
                "Views",
                "merged.profdata"
            ],
            sources: [
                "Models",
                "Parsers"
            ]
        ),
        .target(
            name: "KitMarkdown",
            dependencies: [
                "KitMarkdownCore",
                .product(name: "BeautifulMermaid", package: "beautiful-mermaid-swift"),
                .product(name: "LumiLocalizationKit", package: "LumiLocalization"),
                .product(name: "LumiUI", package: "LumiUI"),
                .product(name: "SwiftTreeSitter", package: "SwiftTreeSitter"),
                .product(name: "TreeSitterSwift", package: "tree-sitter-swift"),
                .product(name: "TreeSitterJavaScript", package: "LumiKitTreeSitterGrammars"),
                .product(name: "TreeSitterTypeScript", package: "tree-sitter-typescript"),
                .product(name: "TreeSitterJSON", package: "tree-sitter-json"),
                .product(name: "TreeSitterPython", package: "LumiKitTreeSitterGrammars"),
                .product(name: "TreeSitterBash", package: "tree-sitter-bash"),
                .product(name: "TreeSitterMarkdown", package: "tree-sitter-markdown"),
                .product(name: "TreeSitterYAML", package: "LumiKitTreeSitterGrammars"),
            ],
            path: ".",
            exclude: [
                "Package.swift",
                "Tests",
                "Models",
                "Parsers",
                "README.md",
                "docs",
                "merged.profdata"
            ],
            sources: [
                "Mermaid",
                "Highlighting",
                "Views"
            ],
            resources: [
                .process("Resources/Localizable.xcstrings"),
                // tree-sitter 高亮查询（与 PluginCodeEditorLanguages 使用同一份查询文件）
                .copy("Resources/tree-sitter-bash"),
                .copy("Resources/tree-sitter-javascript"),
                .copy("Resources/tree-sitter-json"),
                .copy("Resources/tree-sitter-markdown"),
                .copy("Resources/tree-sitter-python"),
                .copy("Resources/tree-sitter-swift"),
                .copy("Resources/tree-sitter-tsx"),
                .copy("Resources/tree-sitter-typescript"),
                .copy("Resources/tree-sitter-yaml"),
            ]
        ),
        .target(
            name: "KitMarkdownTesting",
            dependencies: ["KitMarkdown"],
            path: "Tests/KitMarkdownTesting"
        ),
        .testTarget(
            name: "KitMarkdownCoreTests",
            dependencies: ["KitMarkdownCore"],
            path: "Tests/KitMarkdownCoreTests"
        ),
        .testTarget(
            name: "KitMarkdownTests",
            dependencies: ["KitMarkdown", "KitMarkdownTesting"],
            path: "Tests/KitMarkdownTests"
        )
    ]
)
