import 'dart:convert';

import 'package:angel_container/mirrors.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:koala_chat/koala_chat.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_test/angel_test.dart';
import 'package:koala_chat/src/models/user.dart';
import 'package:test/test.dart';

// Angel also includes facilities to make testing easier.
//
// `package:angel_test` ships a client that can test
// both plain HTTP and WebSockets.
//
// Tests do not require your server to actually be mounted on a port,
// so they will run faster than they would in other frameworks, where you
// would have to first bind a socket, and then account for network latency.
//
// See the documentation here:
// https://github.com/angel-dart/test
//
// If you are unfamiliar with Dart's advanced testing library, you can read up
// here:
// https://github.com/dart-lang/test

main() async {
  // Client for testing
  TestClient client;

  // is ran before execution of tests
  setUp(() async {
    // Set up Angel instance
    var app = Angel(
      // Make sure Angel is using a reflector (not by default)
      reflector: MirrorsReflector(),
    );
    // Await configuration
    await app.configure(configureServer);
    // let client connect to app instance
    client = await connectTo(app);
  });

  // is ran after execution
  tearDown(() async {
    // let client close
    await client.close();
  });

  /* =====================================================================
   *                    ALL TEST BELOW THIS LINE
   * =====================================================================*/

  // USER CONTROLLER
  group('User controller', () {
    // Instantiate a faker for random user information
    Faker faker = Faker();
    // User for global group use
    User user;
    // Token
    String token;

    // Test if user can be created
    setUp(() async {
      // The fake user
      String username = faker.internet.userName().toString();
      String password = faker.internet.password(length: 7).replaceAll('"', ' ');
      // Post the new user
      Response response = await client.post(
        '/user/create',
        body: {
          'username': username.toString(),
          'password': password.toString(),
        },
        headers: {
          'ContentType': 'application/json'
        },
      );
      var jsonData = json.decode(response.body.replaceAll('\\', ''));
      User data = UserSerializer.fromMap(jsonData as Map);
      // validate user creation
      expect(response, allOf([
        hasStatus(200),
        hasBody(),
        isNot(isAngelHttpException())
      ]));
      // Chech server data match our data
      expect(data.username, equals(username));
      expect(data.password, isNot(equals(password)));
      // assign all server-side
      user = data.copyWith(password: password);
    }); // End of Test

    // Test if user can sign in
    test('user can sign in', () async {
      // Send a request with login data to the server
      Response response = await client.post(
        '/auth/local',
        headers: {
          'ContentType': 'application/json'
        },
        body: {
          'username': user.username.toString(),
          'password': user.password.toString(),
        },
      );
      // Check if response body is correct
      expect(response, allOf([
        hasBody(),
        hasStatus(200)
      ]));
      // parse body
      Map jsonData = json.decode(response.body.replaceAll('\\', '')) as Map;
      // Check if password is hidden
      expect(jsonData["data"]["password"], equals(user.safe().password));
      // Check if body contains the token
      expect(jsonData, contains('token'));
      // Set the global token for further testing
      token = jsonData["token"] as String;
    }); // End of Test

    // Delete User
    test('user can be deleted', () async {
      // Send the request
      Response response = await client.post(
        '/user/delete',
        headers: {
          'Authorization': 'Bearer $token'
        }
      );
      print(response);
    }); // End of Test
  }); // User controller group
}
