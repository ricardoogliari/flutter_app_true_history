import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return _buildBody(context);
  }

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
        child: Center(child: Text("${history.numberTrue}")),
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
        child: Center(child: Text("${history.numberFalse}")),
      ),
      title: Text(history.title),
      //flexbox css3 - mesmo conceito usado no cross e main axis
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,//secundário
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
