import 'package:flutter_test/flutter_test.dart';
import 'package:leenhw5/main.dart';

void main() {
  testWidgets('MainApp renders users screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    expect(find.text('Users List'), findsOneWidget);
  });
}
