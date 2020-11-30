import 'package:flutter_app_true_history/model/tagsHistory.dart';

extension TagsHistoryExt on TagsHistory {

  static const historyMap = {
    TagsHistory.FOOD: "Comida",
    TagsHistory.COLD: "Frio",
    TagsHistory.HEALTH: "Saúde",
    TagsHistory.HOT: "Calor",
    TagsHistory.MONEY: "Dinheiro",
  };

  String get about => historyMap[this];
}

