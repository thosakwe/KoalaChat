import 'package:angel_framework/angel_framework.dart';
import 'package:koala_chat/src/models/message.dart';
import 'package:koala_chat/src/models/user.dart';

@Expose('/user')
class UserController extends Controller {
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
  deleteUser(RequestContext req, User user) async {
    Service _service = app.findService('/api/users');

    User delete = await _service.read( user.id) as User;
    
    if (user.password != delete.password || user.hashCode != delete.hashCode ) return AngelHttpException.notAuthenticated();
    return await _service.remove(user.id); 
  }

  @Expose('/messages/:userid')
  getMessages(RequestContext req, String userid) async{
    return await app.findService('/api/messages').index({'query': {'userid': userid}}) as List<Message>;
  }
  @Expose('/messages')
  getMessagesForUser(RequestContext req, User user) async{
    return await app.findService('/api/messages').index({'query': {'userid': user.id}}) as List<Message>;
  }

  @Expose('/join')
  join(User user){
    return user.username;
  }
}
