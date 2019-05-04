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
    // Create instance of new user
    User newUser = User(
      username: req.bodyAsMap["username"].toString(),
      password: req.bodyAsMap["password"].toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
    );
    // Check if user already exists
    try {
      var duplicate = await _service.findOne({'query': {"username": newUser.username}});
      // If already exists return bad request
      if (duplicate is User) return AngelHttpException.badRequest(message: "User already exist");
    } catch (e) {};
    // create new user
    await _service.create(newUser);
  }

  /// Deletes the current authenticated user
  @Expose('/delete', method: 'DELETE')
  deleteUser(RequestContext req, User user) async {
    // Remove user via th user id, since the user already is authenticated we dont need an additional check
    return await app.findService('/api/users').remove(user.id);
    // Return all messages registered to that userid
  }

  /// Retrieves all messages via the userid [PUBLIC_API]
  @Expose('/messages/:userid')
  getMessages(RequestContext req, String userid) async{
    return await app.findService('/api/messages').index({'query': {'userid': userid}}) as List<Message>;
  }

  /// Retrieves all messages, for the currently authenticated user
  @Expose('/messages')
  getMessagesForUser(RequestContext req, User user) async{
    return await app.findService('/api/messages').index({'query': {'userid': user.id}}) as List<Message>;
  }

  /// Redirects authenticated user to chat
  @Expose('/join')
  join(User user){
    // TODO: implement logic
    return user.username;
  }

  /// Admin area
  @Expose('/admin')
  admin(User user){
    // Check wheather the user has Admin status
    if (!checkUserIsAdmin(user)) return AngelHttpException.forbidden(message: 'Only available for admins');
    // TODO: implement admin interface
    return "ACCESS GRANTED";
  }
}
