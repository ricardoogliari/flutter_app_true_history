// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/screen/homePage.dart';
import 'package:flutter_app_true_history/screen/listPage.dart';
import 'package:flutter_app_true_history/screen/mapPage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_true_history/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check App Init', (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());

    Finder finderMap = find.byType(MapPage);
    Finder finderList = find.byType(ListPage);

    expect(finderMap, findsOneWidget);
    expect(finderList, findsNothing);

    /*
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);*/
  });
}
