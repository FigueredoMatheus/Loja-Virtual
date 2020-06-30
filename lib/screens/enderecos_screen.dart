import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/tiles/endereco_tile.dart';
import 'package:provider/provider.dart';

import 'add_endereco_screen.dart';

class EnderecosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Endereços'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.location_on),
                trailing: Icon(Icons.add),
                title: Text('Adicionar Endereço'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AddEnderecoScreen()));
                },
              )),

            Observer(builder: (_) {
              print("Lista de endereços(EnderecoScreen: ${user.endereco.listEnderecos.length}");
                if( user.endereco.listEnderecos.length == 0 ||  user.endereco.listEnderecos.length == null){
                  return Center(child: Text('Nenhum endereço cadastrado.'));
                }else{
                  return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: user.endereco.listEnderecos
                      .map((endereco){
                        return EnderecoTile(user, endereco, false);
                      })
                      .toList()
                  );
                }
            },
            )
        ],
      ),
    );
  }
}
