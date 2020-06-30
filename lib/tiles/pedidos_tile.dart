import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:provider/provider.dart';

class PedidosTile extends StatelessWidget {
  final String documentPedidoId;

  PedidosTile(this.documentPedidoId);

  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);

    return Card(
      color: Color.fromARGB(255, 211, 118, 130),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        //EStreamBuilder faz a verificação dos status em tempo real
        //Como ele ta verificando um documento, usa-se DocumentSapshot
        child: FutureBuilder<DocumentSnapshot>(
            //.snapshot é para ser atualizado em tempo real. .get retorna um futuro n em tempo real
            future: Firestore.instance
                .collection('pedidos')
                .document(documentPedidoId)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                int statusFirebase = snapshot.data['status'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Codigo do pedido: ${snapshot.data.documentID}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 16.0,
                            width: 16.0,
                            color: Color.fromARGB(255, 211, 118, 130),
                            child: IconButton(
                              padding: EdgeInsets.only(right: 5.0, bottom: 6.0),
                              iconSize: 18.0,
                              icon: Icon(Icons.close),
                              color: Colors.black,
                              onPressed: statusFirebase > 3
                                  ? () {
                                user.pedidos.remover(documentPedidoId, user.firebaseUser);
                              }
                                  : null,
                           
                            ),
                          ),
                        ]
                    ),

                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      _buildProdutosText(snapshot.data),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Status do pedido:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStatus('1', 'Preparação', statusFirebase, 1),
                        Container(
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey,
                        ),
                        _buildStatus('2', 'Transporte', statusFirebase, 2),
                        Container(
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey,
                        ),
                        _buildStatus('3', 'Entrega', statusFirebase, 3),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  String _buildProdutosText(DocumentSnapshot snapshotData) {
    String text = "Descrição:\n";

    for (LinkedHashMap p in snapshotData.data['produtos']) {
      text += "${p['quantProdutos']} x ${p['produto']['title']}"
          " ${p['produto']['medida']} (R\$ ${p['produto']['preco'].toStringAsFixed(2).replaceAll('.', ',')})\n";
    }

    text +=
        "Entrega: ${snapshotData.data['entrega'].toStringAsFixed(2).replaceAll('.', ',')}\n"
        "Total: ${snapshotData.data['total'].toStringAsFixed(2).replaceAll('.', ',')}";

    return text;
  }

  Widget _buildStatus(
      String title, String subtitle, int statusFirebase, int status) {
    Color backColor;
    Widget child;

    if (statusFirebase < status) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (statusFirebase == status) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(children: <Widget>[
      CircleAvatar(
        backgroundColor: backColor,
        child: child,
      ),
      Text(subtitle),
    ]);
  }
}
