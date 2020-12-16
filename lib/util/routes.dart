import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/screen/homePage.dart';
import 'package:flutter_app_true_history/screen/newHistory.dart';
import 'dart:core';

Map<String, Widget Function(BuildContext context)> routesInApp = {
  homeRoute: (context) => MyStatefulWidget(),
  newHistoryRoute: (context) => NewHistory()
};

String homeRoute = '/';
String newHistoryRoute = '/newHistory';
