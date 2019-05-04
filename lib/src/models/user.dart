import 'package:angel_serialize/angel_serialize.dart';
import 'package:koala_chat/src/helper/user_helper.dart';
part 'user.g.dart';

@serializable
abstract class _User extends Model {
  @SerializableField(isNullable: false)
  String username;
  @SerializableField(isNullable: false, exclude: true, canDeserialize: true)
  String password;
  @SerializableField(exclude: true, canDeserialize: true, defaultValue: userGroup.REGULAR)
  userGroup group;
}
