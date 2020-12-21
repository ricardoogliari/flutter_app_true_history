// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/screen/newHistory.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidgetForTesting({Widget child}){
  return MaterialApp(
    home: child,
  );
}

void main() {
  testWidgets('Check App Init', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: NewHistory()));

    Finder finderErrorMsg = find.text("Insira o site da história");
    expect(finderErrorMsg, findsNothing);

    await tester.tap(find.byKey(Key("BtnSave")));
    await tester.pump();

    finderErrorMsg = find.text("Insira o site da história");
    expect(finderErrorMsg, findsOneWidget);
  });
}