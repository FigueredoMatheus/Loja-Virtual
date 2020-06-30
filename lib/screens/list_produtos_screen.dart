import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/tiles/produto_tile.dart';

class ListProdutosScreen extends StatelessWidget {
  //Contem a categoria
  final DocumentSnapshot documentSnapshot;

  ListProdutosScreen(this.documentSnapshot );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //Quantidade de Tabs
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 253, 181, 168),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 211, 118, 130),
          title: Text(documentSnapshot.data['title']),
          centerTitle: true,
          //Mostrando os icones das tabs
          bottom: TabBar(
            indicatorColor: Colors.white70,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),),
            ],
          ),
        ),
        //O que será mostrado nas Tabs
        //QuerySnapshot é uma fotografica da coleção ou seja todos os documento
        //DocumentSnapshot é uma fotografia de apenas u documento, os dados do documento
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('Produtos').document(documentSnapshot.documentID)
          .collection('Itens').getDocuments(),
          //Esse snapshot contém cada um dos produtos na categoria
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  //Como pode haver muitos produtos, usa-se .builder
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    //Especificando a configurações dos itens
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //Horizontal
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      ProdutoData produtoData = ProdutoData.fromDocument(snapshot.data.documents[index]);
                      produtoData.categoria = this.documentSnapshot.documentID;
                      return ProdutoTile("grid", produtoData);
                    },
                  ),

                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        ProdutoData produtoData = ProdutoData.fromDocument(snapshot.data.documents[index]);
                        produtoData.categoria = this.documentSnapshot.documentID;
                        return ProdutoTile("list", produtoData);
                      },
                  ),
                ],
              );
            }
          },

        ),
      ),

    );
  }
}
