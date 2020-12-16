import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class NewHistory extends StatefulWidget {
  @override
  _NewHistoryState createState() => _NewHistoryState();
}

class _NewHistoryState extends State<NewHistory> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _searchAddress = TextEditingController();

  String labelCityAdress = "Selecione cidade e/ou endereço";

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
                buildFormFiled("Título", _titleController, 'Insira o título da história'),
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
                buildFormFiled("Site", _titleController, 'Insira o site da história'),
                buildFormFiled("Principal rede social", _titleController, 'Insira a principal rede social da história'),
                buildFormFiled("Outra rede social", _titleController, 'Insira outra rede social da história'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

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

  TextFormField buildFormFiled(String titleHint, TextEditingController controller, String emptyMessage) => TextFormField(
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
    StreamController _controller = StreamController<List<Address>>();
    Stream<List<Address>> stream = _controller.stream;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Busca endereço'),
          content: Container(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                buildFormFiled("Endereço", _searchAddress, 'Insira o endereço a ser buscado...'),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data == null ?
                          [] :
                          snapshot.data.map<Widget>((e) => InkWell(
                            child: Text(e.addressLine),
                            onTap: () {
                              setState(() {
                                labelCityAdress = e.addressLine;
                              });

                              _controller.close();
                              Navigator.of(context).pop();
                            },
                          )).toList()
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

}

