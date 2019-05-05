import 'package:angel_framework/angel_framework.dart';
import 'package:angel_mongo/angel_mongo.dart';
import 'package:koala_chat/src/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

AngelConfigurer configureServer(Db db) {
  return (Angel app) async {
    // In the next `package:angel_framework`, there'll be a
    // `useTyped` method that will make this call less
    // verbose.
    //
    // However, to be able to resolve a typed service,
    // you *must pass* the first two type arguments.
    // `useTyped` will be basically the same, but you
    // will be able to omit the `Service<String, User>`.
    app.use<String, User, Service<String, User>>(
      '/api/users',
      MongoService(db.collection('users'))
          .map(UserSerializer.fromMap, UserSerializer.toMap),
    );
  };
}
