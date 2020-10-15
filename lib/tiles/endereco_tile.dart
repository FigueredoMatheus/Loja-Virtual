import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/screens/add_endereco_screen.dart';

class EnderecoTile extends StatelessWidget {
  final UserMobx user;
  final Map<dynamic, dynamic> endereco;
  final bool isEnderecoCarrinho;

  EnderecoTile(this.user, this.endereco, this.isEnderecoCarrinho);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                endereco['padrao']
                ? Container(
                    height: 15,
                    width: 40,
                    color: Colors.red[200],
                    child: Text(
                      "Padrão",
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox(
                    height: 15,
                  ),
              
              !isEnderecoCarrinho
                  ? Container(
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _bottomSheet(context);
                      },
                    )
                  )
                  
                  : SizedBox(
                      height: 0,
                    ),
            ]),

            Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 13.0),
                child: Text('Rua: ${endereco['rua']}'),
              ),

            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Text('Bairro: ${endereco['bairro']}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 13.0),
              child: Text('Cidade: ${endereco['cidade']}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 13.0),
              child: Text('Estado: ${endereco['estado']}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 13.0),
              child: Text('Número: ${endereco['numero']}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 13.0),
              child: Text('CEP: ${endereco['cep']}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8.0, left: 13),
              child: Text('Complemento: ${endereco['complemento']}'),
            ),
            !isEnderecoCarrinho
                ? SizedBox(
                    height: 0,
                  )
                : FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      user.endereco.enderecoEscolhidoo = endereco;
                      Navigator.pop(context);
                    },
                    child: Text('Selecionar',
                        style: TextStyle(color: Colors.blue)),
                  ),
          ],
        ),
      ),
    );
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                height: 200,
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Editar",
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEnderecoScreen(
                                      endereco: endereco,
                                    )));
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    FlatButton(
                      child: Text(
                        "Excluir",
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      onPressed: () {
                        user.endereco.excluirEndereco(endereco);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    FlatButton(
                        child: Text(
                          endereco['padrao']
                              ? "Remover padrão"
                              : "Definir como padrão",
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),
                        onPressed: () {
                          if (endereco['padrao']) {
                            user.endereco.removerPadrao(endereco);
                          } else {
                            user.endereco.definirPadrao(endereco);
                          }

                          Navigator.pop(context);
                        })
                  ],
                ),
              );
            },
          );
        });
  }
}
