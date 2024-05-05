import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app.dart';
import 'package:flutter_pokedex/core/injection_container/init_core.dart';
import 'package:flutter_pokedex/core/theme/theme.dart';
import 'package:flutter_pokedex/core/theme/theme_provider.dart';
import 'package:flutter_pokedex/core/utils/isar_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// Service locator instance
final sl = GetIt.I;

///
// ignore: type_annotate_public_apis
var isarDB = sl<IsarHelper>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies with the given GetIt service locator as sl
  await initCore(sl);
  await isarDB.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(theme()),
      child: const App(),
    ),
  );
}
