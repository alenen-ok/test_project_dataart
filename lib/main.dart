import 'package:flutter/material.dart';

import 'internal/application.dart';
import 'internal/dependencies/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}
