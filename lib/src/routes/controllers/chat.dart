import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';
import 'package:koala_chat/src/models/message.dart';

class ChatController extends WebSocketController {
  Angel app;
  ChatController(AngelWebSocket ws, this.app) : super(ws);

  @ExposeWs('ping')
  void hello(WebSocketContext socket) {
    socket.send('pong', {
      'message': 'Hello, world!',
    });
  }

  @ExposeWs('message')
  void message(WebSocketContext socket, WebSocketAction action) async {
    Message message = Message(message: action.data["message"].toString(), userid: 'annonymous',createdAt: DateTime.now(), updatedAt: DateTime.now());
    if (message.message.trim().isEmpty || message.message == 'null') {
      socket.sendError(AngelHttpException.badRequest(
          message: "Please specify a valid message"));
    } else {
      await app.findService('/api/messages').create(message);
      broadcast('message', message.toJson());
    }
  }
}
