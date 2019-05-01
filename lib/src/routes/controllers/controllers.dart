library koala_chat.src.routes.controllers;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';

import './user.dart';
import './chat.dart';

Future configureServer(Angel app) async {
  var ws = new AngelWebSocket(app);
  await app.configure(ws.configureServer);
  app.all('/chat', ws.handleRequest);
  /// Controllers will not function unless wired to the application!
  await app.mountController<UserController>();
  await app.mountController<ChatController>();
}
