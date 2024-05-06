import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

///Init the desktop window to full screen and sets a minimum size
Future<void> windowVisibilityService() async {
  //
  if (Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      fullScreen: true,
      minimumSize: Size(1366, 768),
      title: 'Pokedex',
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
