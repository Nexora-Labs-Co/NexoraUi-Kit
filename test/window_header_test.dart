import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexora_ui_kit/nexora_ui_kit.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  testWidgets('renders brand and subtitle', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NexoraWindowHeader(subtitle: 'HARMONY'),
        ),
      ),
    );
    expect(find.text('NEXORA'), findsOneWidget);
    expect(find.text('HARMONY'), findsOneWidget);
    expect(find.byType(DragToMoveArea), findsOneWidget);
  });

  testWidgets('maximized state shows restore button', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NexoraWindowHeader(subtitle: 'SUITE', isMaximized: true),
        ),
      ),
    );
    expect(find.byType(WindowCaptionButton), findsNWidgets(3));
  });

  testWidgets('callbacks are invoked', (tester) async {
    var minimized = false;
    var closed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NexoraWindowHeader(
            subtitle: 'SUITE',
            showWindowControls: true,
            onMinimize: () => minimized = true,
            onClose: () => closed = true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(WindowCaptionButton).first);
    await tester.pump();
    expect(minimized, isTrue);
    await tester.tap(find.byType(WindowCaptionButton).last);
    await tester.pump();
    expect(closed, isTrue);
  });
}
