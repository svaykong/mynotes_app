import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'views/root_view.dart';

void main() async {
  /// Handle error
  /// Unhandled Exception: Binding has not yet been initialized
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env.devs');
  runApp(const RootView());
}
