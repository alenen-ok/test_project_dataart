import 'package:test_project/domain/models/user.dart';

abstract class LoginRepository {
  Future<User?> login(String username, String password);
}
