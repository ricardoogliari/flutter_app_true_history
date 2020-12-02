import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:flutter_app_true_history/model/tagsHistory.dart';
import 'package:flutter_app_true_history/model/tagsHistoryExt.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<History> histories = List();

  @override
  void initState() {
    super.initState();
    histories.add(History.fromJson({
      "title": "Título de exemplo",
      "description": "Descrição de exemplo",
      "city": "Passo Fundo",
      "address": "Rua Padre Acnhieta",
      "site": "Site exemplo",
      "mainSocialNetwork": "Linkedin",
      "otherSocialNetwork": "Facebook",
      "numberTrue": 10,
      "numberFalse": 1,
      "tags": [
        TagsHistory.FOOD.about
      ]
    }));
  }

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  ListView buildListView() => ListView.separated(
      itemBuilder: (context, index) => buildItem(histories[0]),
      separatorBuilder: (context, index) => Divider(height: 1),
      itemCount: 20);

  Widget buildItem(History history) => ListTile(
    leading: Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.black
          )
      ),
      child: Center(child: Text("10")),
    ),
    trailing: Container(
      width: 32,
      height: 32,
      decoration: new BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.black
          )
      ),
      child: Center(child: Text("1")),
    ),
    title: Text(history.title),
    //flexbox css3 - mesmo conceito usado no cross e main axis
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,//secundário
      children: [
        Text(history.description),
        Text(history.city),
        Text(history.address),
        buildChips(history.tags)
      ],
    ),
    isThreeLine: true,
  );

  Widget buildChips(List<String> chips) => Wrap(
    spacing: 12.0,
    runSpacing: 2.0,
    children: buildChildrenChips(chips),
  );

  List<Widget> buildChildrenChips(List<String> chips) =>
      List.generate(
          chips.length,
              (i) => Chip(label: Text(chips[i]))
      );

}
