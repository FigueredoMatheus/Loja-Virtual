import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/tiles/endereco_tile.dart';
import 'package:provider/provider.dart';
import 'package:lojavirtual2/models/user_mobx.dart';

class CardEndereco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);

    void _bottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: user.endereco.listEnderecos.map((endereco) {
                          return EnderecoTile(user, endereco, true);
                        }).toList()),
                  ],
                );
              },
            );
          });
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      //Tem a opção de expandir e mostrar seu conteudo
      child: ExpansionTile(
        title: Text(
          "Endereço",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Observer(
            builder: (_) {
              if (user.endereco.listEnderecos.isEmpty ||
                  (!user.endereco.listEnderecos[0]['padrao'] &&
                      user.endereco.enderecoCarrinhoIndex == -1)) {
              //  user.endereco.enderecoEscolhido = false;
                return SizedBox(
                  child: Column(
                    children: <Widget>[
                      Text('Nenhum endereço padrão definido.'),
                      RaisedButton(
                        child: Text('Escolher endereço'),
                        onPressed: () {
                          _bottomSheet(context);
                        },
                      )
                    ],
                  ),
                );
              }else {
               // user.endereco.enderecoEscolhido = true;
                return Container(
                  padding: EdgeInsets.only(left: 5),
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'Rua: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['rua']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'Bairro: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['bairro']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'Cidade: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['cidade']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'Estado: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['estado']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'Número: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['numero']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                            'CEP: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['cep']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                        child: Text(
                            'Complemento: ${user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]['complemento']}'),
                      ),
                      FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Alterar Endereço',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () {
                          _bottomSheet(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
