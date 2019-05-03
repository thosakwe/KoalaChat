library koala_chat.services;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';

import './message.dart' as messageService;
import './user.dart' as userService;

/// Configure our application to use *services*.
/// Services must be wired to the app via `app.use`.
///
/// They provide many benefits, such as instant REST API generation,
/// and respond to both REST and WebSockets.
///
/// Read more here:
/// https://github.com/angel-dart/angel/wiki/Service-Basics
Future configureServer(Angel app) async {
  Db db = new Db('mongodb://localhost:27017/koalachat');
  await db.open();
  
  await app.configure(userService.configureServer(db));
  
  await app.configure(messageService.configureServer(db));
}
