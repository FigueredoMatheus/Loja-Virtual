import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/screens/list_produtos_screen.dart';

class CategoriaTile extends StatelessWidget {
  //Documento que contém todas as categorias
  final DocumentSnapshot documentSnapshot;

  CategoriaTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    //Estruturando a tela de produtos
    return ListTile(
      //Icone que fica na esquerda
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot.data['icon']),
      ),
      title: Text(
          documentSnapshot.data['title'],
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ListProdutosScreen(documentSnapshot))
        );
      },
    );
  }
}
