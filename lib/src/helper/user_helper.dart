import 'package:angel_validate/angel_validate.dart';
import 'package:koala_chat/src/models/user.dart';

enum userGroup { REGULAR, ADMIN }

bool checkUserIsAdmin(User user) {
  if (user.group != userGroup.ADMIN) {
    return false;
  }
  return true;
}

Validator userValidator = Validator({
  'username,password': [
    isNotEmpty,
    isString,
    minLength(4),
    isNot(contains('"'))
  ],
  'password': [
    minLength(8),
    isAlphaDash,
  ]
});
