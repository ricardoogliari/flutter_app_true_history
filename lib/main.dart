import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/screen/homePage.dart';

void main() {
  //Widget
  runApp(MyApp());
}

//StatelessWidget, StatefulWidget, State
//StatelessWidget = widgets que não aletar o seu estado
//StatefulWidget = widget que pode ter alterações no seu estado
   //quem controla o estado do StafulWidget é justamente o State

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Opção ao MaterialApp: Cupertino
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }

}