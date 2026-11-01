import 'package:flutter_test/flutter_test.dart';
import 'package:hashplus_flutter/main.dart';

void main() {
  testWidgets('MyDay app displays welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('MyDay'), findsWidgets);
  });
}
