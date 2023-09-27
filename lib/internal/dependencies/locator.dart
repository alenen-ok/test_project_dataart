import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:test_project/core/services/navigation_service.dart';
import 'package:test_project/data/local/repositories/transactions_info_repository.dart';
import 'package:test_project/domain/reducers/app_reducer.dart';
import 'package:test_project/domain/repositories/transactions_repository.dart';
import 'package:test_project/domain/states/app_state.dart';
import 'package:test_project/data/local/dbconfig.dart';
import 'package:test_project/data/local/services/users_data_local_service.dart';
import 'package:test_project/data/local/repositories/user_repository.dart';
import 'package:test_project/domain/repositories/login_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton(NavigationService());
  final myDatabase = await LocalDatabase().database;
  injector.registerSingleton(LocalUserService(db: myDatabase));
  injector.registerSingleton<LoginRepository>(UserRepository());
  injector.registerSingleton<TransactionsRepository>(TransactionsInfoRepository());

  injector.registerSingleton(Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  ));
}
