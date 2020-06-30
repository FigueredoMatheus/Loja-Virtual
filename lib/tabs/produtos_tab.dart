import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/tiles/categoria_tile.dart';

class ProdutosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para importar dados do Firebase
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('Produtos').getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          var dividedTiles = ListTile.divideTiles(tiles: snapshot.data.documents.map( (documents) {
            return CategoriaTile(documents);
          }).toList(),
            color: Colors.grey,
          ).toList();

          return ListView(
            //Pega cada documento; troca o documento por um CategoriaTile e transforma em uma lista
            children: dividedTiles,
          );
        }
      },
    );
  }
}
