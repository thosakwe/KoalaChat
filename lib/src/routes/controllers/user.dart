import 'package:dbcrypt/dbcrypt.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:koala_chat/src/models/message.dart';
import 'package:koala_chat/src/models/user.dart';
import 'package:koala_chat/src/helper/user_helper.dart';

@Expose('/user')
class UserController extends Controller {
  /// Create a User and insert it into the database
  /// needs valid req.body
  @Expose('/create', method: 'POST')
  createUser(RequestContext req) async {
    // parse body
    await req.parseBody();
    // Get the user service connection
    Service _service = app.findService('/api/users');
    // retrieve information
    String username = req.bodyAsMap["username"] as String;
    String password = req.bodyAsMap["password"] as String;
    // Validate userinfo
    var check =
        userValidator.check({'username': username, 'password': password});
    if (check.errors.isNotEmpty) {
      throw AngelHttpException.badRequest(
          message: 'Please provide a valid input', errors: check.errors);
    }
    // Create "secure" password hash with DBCrypt, the jBCrypt implememntation
    var digestedPW = DBCrypt().hashpw(password, DBCrypt().gensalt());
    // Check if user already exists
    List duplicate = await _service.index({
      'query': {"username": username}
    });
    duplicate.isNotEmpty
        ? throw AngelHttpException.badRequest(message: "User already exist")
        : null;
    // create new user
    await _service.create(
      User(
        username: username,
        password: digestedPW.toString(),
        group: userGroup.REGULAR,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    return {"path": "success","message": "Registration successful"};
  }

  /// Deletes the current authenticated user
  @Expose('/delete', method: 'DELETE')
  deleteUser(RequestContext req, User user) async {
    // Remove user via th user id, since the user already is authenticated we dont need an additional check
    return await app.findService('/api/users').remove(user.id);
    // Return all messages registered to that userid
  }

  /// Retrieves all messages, for the currently authenticated user
  @Expose('/messages')
  getMessagesForUser(RequestContext req, User user) async {
    return await app.findService('/api/messages').index({
      'query': {'userid': user.id}
    }) as List<Message>;
  }

  /// Admin area
  @Expose('/admin')
  admin(User user) {
    // Check wheather the user has Admin status
    if (!checkUserIsAdmin(user))
      return AngelHttpException.forbidden(message: 'Only available for admins');
    // TODO: implement admin interface
    return "ACCESS GRANTED";
  }
}
