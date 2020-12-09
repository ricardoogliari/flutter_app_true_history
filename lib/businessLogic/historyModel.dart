import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/model/history.dart';

//atua commo um publisher
class HistoryModel extends ChangeNotifier{

  //nós temos uma lista privada
  final List<History> _histories = [];

  //lista pública e imutável
  UnmodifiableListView<History> get histories => UnmodifiableListView(_histories);

  void add(History item) {
    _histories.add(item);
    //pede pro changeNotifierProvider avisar todos os consumers
    //ou, em uma linguagem pub-sub, pede pro channel avisar os subscribers
    notifyListeners();
  }

  void setHistories(List<DocumentSnapshot> snapshot) {
    List<History> itens = snapshot.map<History>((e) => History.fromJson(e.data())).toList();

    _histories.clear();
    _histories.addAll(itens);
    notifyListeners();
  }

}
