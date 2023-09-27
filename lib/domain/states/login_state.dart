import 'package:test_project/domain/models/user.dart';

class LoginFormState {
  bool isFailure;
  User? user;

  LoginFormState({this.isFailure = false, this.user});

  factory LoginFormState.initial() => LoginFormState();
}
