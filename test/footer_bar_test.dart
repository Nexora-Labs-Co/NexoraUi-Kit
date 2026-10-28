import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexora_ui_kit/nexora_ui_kit.dart';

void main() {
  testWidgets('renders left and right content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NexoraFooterBar(
            left: Text('status'),
            right: Text('links'),
          ),
        ),
      ),
    );
    expect(find.text('status'), findsOneWidget);
    expect(find.text('links'), findsOneWidget);
  });
}
