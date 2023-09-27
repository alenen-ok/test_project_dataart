import 'package:test_project/data/local/entities/user_entity.dart';

class User {
  String userName;

  User({required this.userName});

  User.fromDto(UserEntity user) : userName = user.login;
}
