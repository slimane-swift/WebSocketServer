import PackageDescription

let package = Package(
    name: "WebSocketServer",
    dependencies: [
        .Package(url: "https://github.com/slimane-swift/WebSocket.git", majorVersion: 0, minor: 1),
    ]
)
