import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtual2/screens/carrinho_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  //Criando um fondo degrade
  Widget _buildBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            List: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          _buildBodyBack(),
//Para poder criar Grids com tamanhos diferentes
          CustomScrollView(
            //So pode ser colocado componentes do tipo Sliver
            slivers: <Widget>[
              SliverAppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    color: Color.fromARGB(240, 255, 122, 173),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CarrinhoScreen())
                      );
                    },
                  ),
                ],
                floating: true,
                snap: true, //Quando estiver rolando para baixo a barra some e com uma rolada para cima ela aparece
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text("Novidades"), // Como é titulo constante, é importante colocar const
                  centerTitle: true,
                ),
              ),
              FutureBuilder<QuerySnapshot>(
                future: Firestore.instance.collection("home").orderBy('pos').getDocuments(),
                //Função que irá criar que terá na dela dependendo do q for retornado do future
                builder: (context, snapshot){
                  if(!snapshot.hasData) {
                    //Adaptando um Widget para Sliver
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  }else{
                    //Como ja se sabe a quantidade de itens, usa-se o construtor count da classe
                    return SliverStaggeredGrid.count(
                      //Quantidade de blocos na horizontal
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      //lista de dimensões contendo a timensão de cada uma das Tiles
                      //Essa lista tem q ser no formato StaggeredTile.count
                      //Mapeando a lista de documentos usando uma função anonima
                      //Para cada um dos documentos da lista, a função é chamada
                      staggeredTiles: snapshot.data.documents.map(
                              (document)  {
                            return StaggeredTile.count(document.data['x'], document.data['y']);
                          }
                      ).toList(),
                      //Especificando uma lista de imagens
                      //Criando uma lista com as imagens para ser os filhos
                      children: snapshot.data.documents.map(
                              (document){
                            return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: document.data['image'],
                              fit: BoxFit.cover,
                            );
                          }
                      ).toList(),


                    );
                  }
                },

              ),
            ],
          ),
        ],
      ),
    );
  }
}
