import 'package:angel_framework/angel_framework.dart';
import 'package:koala_chat/src/models/message.dart';
import 'package:koala_chat/src/models/user.dart';

@Expose('/user')
class UserController extends Controller {
  UserController();

  @Expose('/create', method: 'POST')
  createUser(RequestContext req) async {
    await req.parseBody();
    Service _service = app.findService('/api/users');
    
    User newUser = User(
      username: req.bodyAsMap["username"] as String,
      password: req.bodyAsMap["password"] as String
    );

    List duplicate = await _service.index({'query': newUser.toJson()});
    if (duplicate.isNotEmpty) return AngelHttpException.badRequest(message: "User already exist"); 

    return await _service.create(newUser);
  }

  @Expose('/delete', method: 'DELETE')
  deleteUser(RequestContext req) async {
    await req.parseBody();
    Service _service = app.findService('/api/users');

    User user = await _service.findOne({'query': {'username': req.bodyAsMap["username"]}}) as User;
    
    if (user.password != req.bodyAsMap["password"]) return AngelHttpException.notAuthenticated();
    return await _service.remove(user.id); 
  }

  @Expose('/messages/:userid')
  getMessages(RequestContext req, String userid) async{
    Service _service = app.findService('/api/messages');

    List<Message> messages = await _service.index({'query': {'userid': userid}}) as List<Message>;

    return messages;
  }
}
