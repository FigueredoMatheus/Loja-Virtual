import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:provider/provider.dart';

class ChangeNameScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    UserMobx user = Provider.of<UserMobx>(context);

    TextEditingController _nomeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar nome"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),

        backgroundColor: Colors.white,

        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    hintText: "Novo nome",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (text){
                    if(text == "") return "Insira seu novo nome.";
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      user.changeNome(_nomeController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  color:Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Salvar"),
                ),
              ),

            ],
          ),
        ),

      );
  }
}
