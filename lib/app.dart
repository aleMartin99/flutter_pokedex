// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Base class for the application

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    //initialize responsive sizer package
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          // theme: AppThemes.getLightTheme(),
          debugShowCheckedModeBanner: false,
          home: const AppRouter(),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRoutes.homeScreenRoute,
        );
      },
    );
  }
}