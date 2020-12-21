import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/screen/homePage.dart';
import 'package:provider/provider.dart';

void main() async{
  //garanto que toda inicialização do flutter necessária já foi feita
  WidgetsFlutterBinding.ensureInitialized();
  //aguarda alguns instantes garantindo que o Firebase seja inicializado
  await Firebase.initializeApp();
  runApp(
    //informa pro filho (HOmePage) e seus descendentes (Widget Tree) que eles
    //podem ler e/ou alterar um changeNotifier informado no create
    HomePage(),
  );
}
