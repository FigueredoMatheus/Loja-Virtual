import 'package:flutter/material.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/screens/produto_screen.dart';

class ListProdutosTile extends StatelessWidget {

  final ProdutoData produto;

  ListProdutosTile(this.produto);

  @override
  Widget build(BuildContext context) {
    //Parecido do GestureDetector, mas esse tem uma animação ao tocar
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProdutoScreen(this.produto))
        );
      },
      //Cartão que tem uma pequena elevação
      child: Card(
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                produto.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white70,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Text(produto.title,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0)),
                    ),
                    Text(
                      "R\$ ${produto.preco[0].toStringAsFixed(2).replaceAll(
                          '.', ',')}",
                      style: TextStyle(color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }