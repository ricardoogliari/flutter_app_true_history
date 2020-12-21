import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:flutter_app_true_history/model/tagsHistory.dart';
import 'package:flutter_app_true_history/model/tagsHistoryExt.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {

  HistoryModel model;

  //pública
  @override
  Widget build(BuildContext context) {
    model = Provider.of<HistoryModel>(context, listen: false);
    return _buildBody(context);
  }

  //privadas: underline
  Widget _buildBody(BuildContext context) {
    return Consumer<HistoryModel>(
      builder: (context, cart, child) {
        return _buildList(context, cart.histories);
      },
    );
  }

  Widget _buildList(BuildContext context, List<History> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, History history) => ListTile(
      leading: InkWell(
        onTap: () {
          model.realHistory(history);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.black
              )
          ),
          child: Center(child: Text("${history.numberTrue}")),
        ),
      ),
      trailing: InkWell(
        onTap: () {
          model.fakeHistory(history);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.black
              )
          ),
          child: Center(child: Text("${history.numberFalse}")),
        ),
      ),
      title: Text(history.title),
      //flexbox css3 - mesmo conceito usado no cross e main axis
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //secundário
        children: [
          Text(history.description),
          Text(history.city),
          Text(history.address),
          _buildChips(history.tags)
        ],
      ),
      isThreeLine: true,
    );

  Widget _buildChips(List<String> chips) => Wrap(
    spacing: 12.0,
    runSpacing: 2.0,
    children: _buildChildrenChips(chips),
  );

  List<Widget> _buildChildrenChips(List<String> chips) =>
      List.generate(
          chips.length,
              (i) => Chip(label: Text(chips[i]))
      );

}
