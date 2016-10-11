# WebSocketServer

WebSocket Middleware/Responder for Slimane

## Usage

### Server
```swift
import WebSocketServer
import Slimane

let app = Slimane()

let wsServer = WebSocketServer { socket, request in
    socket.onText { text in
        socket.send("PONG")
    }
}

app.use(wsServer)

try! app.listen()
```
## License

WS is released under the MIT license. See LICENSE for details.
