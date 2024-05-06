import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/captured_screen/captured_screen_exports.dart';

/// Captured screen
class CapturedScreen extends StatelessWidget {
  ///
  const CapturedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CapturedBody(),
    );
  }
}
