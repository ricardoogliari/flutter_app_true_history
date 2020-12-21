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
    notifyListeners();
  }

  void saveHistory(History item) {
    FirebaseFirestore.instance.collection('history').add(
      item.toJson()
    );
  }

  void realHistory(History item) {
    item.numberTrue++;

    if (item.reference != null) {
      saveItemInFirebase(item);
    }
  }

  void fakeHistory(History item) {
    item.numberFalse++;

    if (item.reference != null) {
      saveItemInFirebase(item);
    }
  }

  void saveItemInFirebase(History item){
    item.reference.set(item.toJson());
  }

  void setHistories(List<DocumentSnapshot> snapshot) {
    List<History> itens = snapshot.map<History>((e) => History.fromJson(e.reference, e.data())).toList();

    _histories.clear();
    _histories.addAll(itens);
    notifyListeners();
  }

}
