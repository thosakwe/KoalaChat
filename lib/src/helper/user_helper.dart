import 'package:koala_chat/src/models/user.dart';

enum userGroup {
  REGULAR,
  ADMIN
}

bool checkUserIsAdmin(User user) {
  if(user.group != userGroup.ADMIN){
    return false;
  }
  return true;
}
