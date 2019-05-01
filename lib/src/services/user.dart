import 'package:angel_framework/angel_framework.dart';
import 'package:angel_mongo/angel_mongo.dart';
import 'package:koala_chat/src/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

AngelConfigurer configureServer(Db db) {
  return (Angel app) async {
    app.use('/api/users', MongoService(db.collection('users')).map(UserSerializer.fromMap, UserSerializer.toMap));
  };
}
