import 'package:angel_serialize/angel_serialize.dart';
import 'package:koala_chat/src/helper/user_helper.dart';
part 'user.g.dart';

@serializable
abstract class _User extends Model {
  @SerializableField(isNullable: false)
  String username;
  @SerializableField(isNullable: false)
  String password;
  @SerializableField()
  userGroup group;

  User safe() => (this as User).copyWith(password: 'hidden');
}
