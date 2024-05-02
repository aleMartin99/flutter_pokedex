import 'package:flutter_pokedex/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
  });
}
