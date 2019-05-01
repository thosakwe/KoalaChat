import 'package:angel_serialize/angel_serialize.dart';
part 'message.g.dart';

@serializable
abstract class _Message extends Model {
  @SerializableField(isNullable: false)
  String userid;
  @SerializableField(isNullable: false)
  String message;
}
