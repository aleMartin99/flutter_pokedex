import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app.dart';
import 'package:flutter_pokedex/core/injection_container/init_core.dart';
import 'package:flutter_pokedex/core/services/services_exports.dart';
import 'package:flutter_pokedex/core/theme/theme_exports.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// Service locator instance
final sl = GetIt.I;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowVisibilityService();

  // Initialize all dependencies with the given GetIt service locator as sl
  await initCore(sl);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(theme()),
      child: const App(),
    ),
  );
}
