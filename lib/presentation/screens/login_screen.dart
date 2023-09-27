import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/core/constants/colors.dart';
import 'package:test_project/core/services/navigation_service.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/domain/actions/login_actions.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/presentation/widgets/buttons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final NavigationService _navigationService = injector<NavigationService>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.fromStore(store),
          builder: (BuildContext context, _ViewModel vm) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Имя пользователя',
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Пароль',
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: AppColors.error,
                        )),
                      ),
                      validator: (_) => vm.isFailure ? "Неверный пароль" : null,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    const SizedBox(height: 50),
                    DefaultFilledButton(
                      label: "Вход",
                      onTap: () {
                        vm.onLoginTap(
                          usernameController.text,
                          passwordController.text,
                          () => _navigationService.navigateToReplacement("main_screen"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function(String, String, VoidCallback) onLoginTap;
  final bool isFailure;

  _ViewModel({required this.onLoginTap, required this.isFailure});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        onLoginTap: (userName, password, onComplete) {
          if (userName.isEmpty || password.isEmpty) return;
          Completer completer = Completer();
          store.dispatch(login(userName, password, completer));
          completer.future.then((value) {
            if (completer.isCompleted) {
              onComplete.call();
            }
          }, onError: (_) {
            store.dispatch(
              LoginFormAction(
                type: LoginFormActionType.loginFail,
                data: "Wrong password",
              ),
            );
          });
        },
        isFailure: store.state.loginState.isFailure);
  }
}
