import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexora_ui_kit/nexora_ui_kit.dart';

void main() {
  testWidgets('renders three sections', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NexoraActionBar(
            left: Text('L'),
            center: Text('C'),
            right: Text('R'),
          ),
        ),
      ),
    );
    expect(find.text('L'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('R'), findsOneWidget);
  });
}
