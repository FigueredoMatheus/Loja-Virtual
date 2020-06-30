import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/tiles/list_produtos_tile.dart';

class ProdutosGridTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('produtos2').getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return GridView.builder(
//              padding: EdgeInsets.all(4.0),
              //Especificando a configurações dos itens
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //Horizontal
                crossAxisCount: 3,
                //mainAxisSpacing: 6.0,
                //crossAxisSpacing: 1.0,
                childAspectRatio: 0.65,
              ),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                ProdutoData produtoData = ProdutoData.fromDocument(snapshot.data.documents[index]);
                return ListProdutosTile(produtoData);
              },
            );
          }
        },
      );
  }
}
