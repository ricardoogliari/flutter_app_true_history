import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/model/history.dart';

class HistoryModel extends ChangeNotifier{

  final List<History> _histories = [];

  UnmodifiableListView<History> get histories => UnmodifiableListView(_histories);

  void add(History item) {
    _histories.add(item);
    notifyListeners();
  }

  void setHistories(List<DocumentSnapshot> snapshot) {
    List<History> itens = snapshot.map<History>((e) => History.fromJson(e.data())).toList();

    _histories.clear();
    _histories.addAll(itens);
    notifyListeners();
  }

}