import 'package:angel_serialize/angel_serialize.dart';
part 'user.g.dart';

@serializable
abstract class _User extends Model {
  @SerializableField(isNullable: false)
  String username;
  @SerializableField(isNullable: false)
  String password;
}
