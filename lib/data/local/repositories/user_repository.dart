import 'package:test_project/data/local/entities/user_entity.dart';
import 'package:test_project/data/local/services/users_data_local_service.dart';
import 'package:test_project/domain/models/user.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/domain/repositories/login_repository.dart';

class UserRepository implements LoginRepository {
  final localUserService = injector<LocalUserService>();

  @override
  Future<User?> login(String username, String password) async {
    UserEntity? userEntity = await localUserService.findUserByLogin(username);
    if (userEntity == null) {
      await localUserService.saveUser(username, password.hashCode.toString()); // change to normal hash
      return User(userName: username);
    }
    bool isPasswordCorrect =
        await localUserService.checkPassword(username, password.hashCode.toString()); // change to normal hash

    if (isPasswordCorrect) {
      return User(userName: username);
    }
    return null;
  }
}
