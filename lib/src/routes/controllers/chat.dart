import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';

class ChatController extends WebSocketController {
  ChatController(AngelWebSocket ws) : super(ws) {
    print(ws); // <= Doesnt execute :(
  }

  @ExposeWs('ping')
  void hello(WebSocketContext socket, WebSocketAction action) {
    socket.send('pong', {
      'message': 'Hello, world!',
      'request': action.data["message"],
    });
  }

  @ExposeWs('message')
  void message(WebSocketContext socket, WebSocketAction action) {
    String message = action.data["message"].toString();

    if (message.trim().isEmpty || message == 'null') {
      socket.sendError(AngelHttpException.badRequest(
          message: "Please specify a valid message"));
    } else {
      broadcast('message', {'message': message});
    }
  }
}
