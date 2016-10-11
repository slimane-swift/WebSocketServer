@_exported import WebSocket

public class WebSocketServer: Middleware {
    
    private let didConnect: (WebSocket, Request) -> Void
    
    public init(_ didConnect: @escaping (WebSocket, Request) -> Void) {
        self.didConnect = didConnect
    }
    
    public func respond(_ request: Request, _ response: Response, _ responder: @escaping (Chainer) -> Void) {
        guard request.isWebSocket && request.webSocketVersion == "13", let key = request.webSocketKey else {
            return responder(.next(request, response))
        }
        
        var response = response
        
        guard let accept = WebSocket.accept(key) else {
            response.status = .internalServerError
            responder(.respond(response))
            return
        }
        
        response.headers = [
            "Connection": "Upgrade",
            "Upgrade": "websocket",
            "Sec-WebSocket-Accept": accept
        ]
        
        response.status = .switchingProtocols
        
        let upgrade: (Request, DuplexStream) -> Void = { request, stream in
            let socket = WebSocket(stream: stream, mode: .server)
            self.didConnect(socket, request)
            socket.start()
        }
        
        response.upgradeConnection = upgrade
        responder(.respond(response))
    }
}

public extension Message {
    
    public var webSocketVersion: String? {
        return headers["Sec-Websocket-Version"]
    }
    
    public var webSocketKey: String? {
        return headers["Sec-Websocket-Key"]
    }
    
    public var webSocketAccept: String? {
        return headers["Sec-WebSocket-Accept"]
    }
    
    public var isWebSocket: Bool {
        return connection?.lowercased() == "upgrade" && upgrade?.lowercased() == "websocket"
    }
    
}
