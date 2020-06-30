import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:provider/provider.dart';

class AddEnderecoScreen extends StatefulWidget {
  final Map<dynamic, dynamic> endereco;

  AddEnderecoScreen({this.endereco});

  @override
  _AddEnderecoScreenState createState() =>
      _AddEnderecoScreenState(endereco: endereco);
}

class _AddEnderecoScreenState extends State<AddEnderecoScreen> {
  final Map<dynamic, dynamic> endereco;

  _AddEnderecoScreenState({this.endereco});

  final _formKey = GlobalKey<FormState>();

  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final numeroController = TextEditingController();
  final cepController = TextEditingController();
  final complementoController = TextEditingController();

  bool _edited = false;
  bool _padrao = false;
  bool _initialPadrao;

  @override
  void initState() {
    super.initState();

    if (endereco != null) {
      _initialPadrao = endereco['padrao'];
      ruaController.text = endereco['rua'];
      bairroController.text = endereco['bairro'];
      cidadeController.text = endereco['cidade'];
      estadoController.text = endereco['estado'];
      numeroController.text = endereco['numero'];
      cepController.text = endereco['cep'];
      _padrao = endereco['padrao'];
      complementoController.text = endereco['complemento'];
    }
  }

  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: endereco != null ? _requestPop : null,
        child: Scaffold(
          appBar: AppBar(
            title: Text(endereco == null ? 'Novo Endereço' : 'Editar Endereço'),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: ruaController,
                    validator: (text) {
                      if (text.isEmpty) return "Compo obrigatório";
                      return null;
                    },
                    onChanged: endereco != null
                        ? (text) {
                            _edited = true;
                          }
                        : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "Rua*",
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: bairroController,
                    validator: (text) {
                      if (text.isEmpty) return "Compo obrigatório";

                      return null;
                    },
                    onChanged: endereco != null
                        ? (text) {
                            _edited = true;
                          }
                        : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "Bairro*",
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: cidadeController,
                    validator: (text) {
                      if (text.isEmpty) return "Compo obrigatório";

                      return null;
                    },
                    onChanged: endereco != null
                        ? (text) {
                            _edited = true;
                          }
                        : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "Cidade*",
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: estadoController,
                    validator: (text) {
                      if (text.isEmpty) return "Compo obrigatório";

                      return null;
                    },
                    onChanged: endereco != null
                        ? (text) {
                            _edited = true;
                          }
                        : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "Estado*",
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 60,
                        //color: Colors.white,
                        child: TextFormField(
                          controller: numeroController,
                          validator: (text) {
                            if (text.isEmpty) return "Compo obrigatório";

                            return null;
                          },
                          onChanged: endereco != null
                              ? (text) {
                                  _edited = true;
                                }
                              : null,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 20),
                            labelText: "Número*",
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          // style: TextStyle(color: Colors.black, fontSize: 20),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 60,
                        child: TextFormField(
                          controller: cepController,
                          validator: (text) {
                            if (text.isEmpty) return "Compo obrigatório";

                            return null;
                          },
                          onChanged: endereco != null
                              ? (text) {
                                  _edited = true;
                                }
                              : null,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 20),
                            labelText: "CEP*",
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          //style: TextStyle(color: Colors.black, fontSize: 20),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: complementoController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "Complemento",
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    onChanged: endereco != null
                        ? (text) {
                            _edited = true;
                          }
                        : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Definir como padrão',
                      //style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: _padrao,
                      onChanged: (value) {
                        _edited = true;
                        setState(() {
                          _padrao = value;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  height: 50,
                  width: 50,
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (endereco == null) {
                          user.endereco.adicionarEndereco(
                            rua: ruaController.text,
                            bairro: bairroController.text,
                            cidade: cidadeController.text,
                            estado: estadoController.text,
                            numero: numeroController.text,
                            cep: cepController.text,
                            padrao: _padrao,
                            complemento: complementoController.text,
                          );
                        } else {
                          if (_initialPadrao == false && _padrao == true) {
                            user.endereco.definirPadrao(endereco);
                          }
                          endereco['rua'] = ruaController.text;
                          endereco['bairro'] = bairroController.text;
                          endereco['cidade'] = cidadeController.text;
                          endereco['estado'] = estadoController.text;
                          endereco['numero'] = numeroController.text;
                          endereco['cep'] = cepController.text;
                          endereco['padrao'] = _padrao;
                          endereco['complemento'] = complementoController.text;

                          user.endereco.editarEndereco(endereco);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    //Verificar se algum texto foi editado
    if (_edited) {
      showDialog(
          context: context,
          builder: (context) {
            //AlertDialog é uma tela, logo um pop irá remove-la
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              //Conteúdo
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    //Saindo sem retornar nada
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  //Saindo do Dialog e do ContatoPage
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      //Para nao sair automaticamente
      return Future.value(false);
    } else {
      //Para sair automaticamente
      return Future.value(true);
    }
  }
}
