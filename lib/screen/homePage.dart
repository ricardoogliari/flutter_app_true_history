import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/businessLogic/currentPosition.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/screen/mapPage.dart';
import 'package:flutter_app_true_history/screen/listPage.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyStatefulWidget(),
    );
  }

}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MapPage(),
    ListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setup() {
    GetIt.I.registerSingleton<CurrentPosition>(CurrentPosition());
  }

  @override
  void initState() {
    super.initState();

    setup();

    GetIt.I<CurrentPosition>().getCurrentPosition();

    HistoryModel model = Provider.of<HistoryModel>(context, listen: false);
    FirebaseFirestore.instance.collection('history').snapshots().listen((event) {
      model.setHistories(event.docs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórias'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
