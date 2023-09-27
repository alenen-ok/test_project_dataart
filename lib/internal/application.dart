import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/internal/dependencies/locator.dart';
import 'package:test_project/core/services/navigation_service.dart';
import 'package:test_project/presentation/screens/details_screen.dart';
import 'package:test_project/presentation/screens/main_screen.dart';
import 'package:test_project/presentation/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: injector<Store<AppState>>(),
      child: MaterialApp(
        navigatorKey: injector<NavigationService>().navigationKey,
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          "login_screen": (BuildContext context) => LoginScreen(),
          "main_screen": (BuildContext context) => const MainScreen(),
          "details_screen": (BuildContext context) => DetailsScreen(),
        },
      ),
    );
  }
}
