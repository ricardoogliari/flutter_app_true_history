import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  group('HistoryModel', () {
    test("real history", () {
      final history = History(
          numberTrue: 0,
          numberFalse: 0
      );
      final historyModel = HistoryModel();

      historyModel.realHistory(history);

      expect(history.numberTrue, 1);
    });

    test("fake history", (){
      final history = History(
          numberTrue: 0,
          numberFalse: 0
      );
      final historyModel = HistoryModel();

      historyModel.fakeHistory(history);

      expect(history.numberFalse, 1);
    });
  });


}