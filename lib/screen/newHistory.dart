import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_true_history/businessLogic/historyModel.dart';
import 'package:flutter_app_true_history/model/history.dart';
import 'package:flutter_app_true_history/model/tagsHistory.dart';
import 'package:flutter_app_true_history/model/tagsHistoryExt.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

class NewHistory extends StatefulWidget {
  @override
  _NewHistoryState createState() => _NewHistoryState();
}

class _NewHistoryState extends State<NewHistory> {

  final _formKey = GlobalKey<FormState>();

  Address _selectedAddress;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _mainSocialNetworkController = TextEditingController();
  final TextEditingController _otherSocialNetworkController = TextEditingController();
  final TextEditingController _searchAddress = TextEditingController();

  String labelCityAdress = "Selecione cidade e/ou endereço";

  List<bool> _statesChips = List.generate(TagsHistory.values.length, (index) => false);
  List<String> _tagsToSave = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova história"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildFormField("Título", _titleController, 'Insira o título da história'),
                buildFormField("Descrição", _descController, 'Insira a descrição da história'),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: InkWell(
                    child: Text(
                      labelCityAdress,
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    onTap: () {
                      _showMyDialog(context);
                    },
                  ),
                ),
                buildFormField("Site", _siteController, 'Insira o site da história'),
                buildFormField("Principal rede social", _mainSocialNetworkController, 'Insira a principal rede social da história'),
                buildFormField("Outra rede social", _otherSocialNetworkController, 'Insira outra rede social da história'),
                SizedBox(height: 16),
                buildChips(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        History history = History.full(
                            _titleController.text,
                            _descController.text,
                            _selectedAddress.subAdminArea,
                            _selectedAddress.addressLine,
                            _siteController.text,
                            _mainSocialNetworkController.text,
                            _otherSocialNetworkController.text,
                            1,
                            0,
                            _tagsToSave,
                            _selectedAddress.coordinates.latitude,
                            _selectedAddress.coordinates.longitude);

                        HistoryModel model = Provider.of<HistoryModel>(context, listen: false);
                        model.saveHistory(history);
                        Navigator.of(context).pop();

                      }
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildFormField(String titleHint, TextEditingController controller, String emptyMessage) => TextFormField(
    decoration: InputDecoration(
        hintText: titleHint,
        labelText: titleHint
    ),
    controller: controller,
    validator: (value) {
      if (value.isEmpty) {
        return emptyMessage;
      }
      return null;
    },
  );

  Future<void> _showMyDialog(BuildContext context) async {
    //publisher - subscriber
    //sink - publisher
    //streamcontroller - channel/broker
    //stream - subscriber
    final StreamController _controller = StreamController<List<Address>>();
    Stream<List<Address>> stream = _controller.stream;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Busca endereço'),
          content: Container(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                buildFormField("Endereço", _searchAddress, 'Insira o endereço a ser buscado...'),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                          snapshot.data == null ? [] :
                          snapshot.data.map<Widget>((address) => InkWell(
                            child: Text(address.addressLine),
                            onTap: () {
                              _selectedAddress = address;
                              setState(() {
                                labelCityAdress = address.addressLine;
                              });

                              _controller.close();
                              Navigator.of(context).pop();
                              _searchAddress.clear();
                            },
                          )
                        ).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Buscar'),
              onPressed: () async {
                var addresses = await Geocoder.local.findAddressesFromQuery(_searchAddress.text);
                var first = addresses.first;
                print("${first.addressLine} : ${first.coordinates} : ${first.subAdminArea}");
                _controller.sink.add(addresses);
              },
            ),
          ],
        );
      },
    );
  }

  Wrap buildChips(){
    List<ChoiceChip> chips = TagsHistory.values.map<ChoiceChip>((element) {
      return ChoiceChip(
          selected: _statesChips[element.index],
          label: Text(element.about),
          onSelected: (value) {
            setState(() {
              _statesChips[element.index] = value;
            });

            if (_statesChips[element.index]){
              _tagsToSave.add(element.about);
            } else {
              _tagsToSave.remove(element.about);
            }
          });
    }).toList();
    return Wrap(
        spacing: 10,
        children: chips
    );
  }


}
