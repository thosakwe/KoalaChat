library koala_chat;

import 'dart:async';
import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'package:koala_chat/src/models/user.dart';
import 'src/config/config.dart' as configuration;
import 'src/routes/routes.dart' as routes;
import 'src/services/services.dart' as services;

/// Configures the server instance.
Future configureServer(Angel app) async {
  // Grab a handle to the file system, so that we can do things like
  // serve static files.
  var fs = const LocalFileSystem();
  // Initiate Authentification
  AngelAuth<User> auth = AngelAuth<User>();
  
  auth.strategies['local'] = LocalAuthStrategy((username, password) async {
    User user = await app.findServiceOf<String, User>('/api/users').findOne({'query': {"username":username}});
    if (user.password == password) return user;
  });

  app.post('/auth', auth.authenticate('local'));

  // Set up our application, using the plug-ins defined with this project.
  await app.configure(configuration.configureServer(fs));
  await app.configure(services.configureServer);
  await app.configure(routes.configureServer(fs));
}
