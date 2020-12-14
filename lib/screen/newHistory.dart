import 'package:flutter/material.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/place_picker.dart';

class NewHistory extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

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
                buildFormFiled("Cidade", _titleController, 'Insira a cidade da história'),
                buildFormFiled("Endereço", _titleController, 'Insira o endereço da história'),
                buildFormFiled("Site", _titleController, 'Insira o site da história'),
                buildFormFiled("Principal rede social", _titleController, 'Insira a principal rede social da história'),
                buildFormFiled("Outra rede social", _titleController, 'Insira outra rede social da história'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                      },
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
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

  /*
  this.title,
      this.description,
      this.city,
      this.address,
      this.site,
      this.mainSocialNetwork,
      this.otherSocialNetwork,
      this.numberTrue,
      this.numberFalse,
      this.tags,
      this.latitude,
      this.longitude)
   */

}
