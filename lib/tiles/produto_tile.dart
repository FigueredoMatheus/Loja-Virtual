import 'package:flutter/material.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/screens/produto_screen.dart';

class ProdutoTile extends StatelessWidget {

  final String tipo;
  final ProdutoData produto;

  ProdutoTile(this.tipo, this.produto);

  @override
  Widget build(BuildContext context) {
    //Parecido do GestureDetector, mas esse tem uma animação ao tocar
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProdutoScreen(this.produto))
        );
      },
      //Cartão que tem uma pequena elevação
      child: Card(
        child: tipo == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(
                    produto.images[1],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white70,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(produto.title, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        "R\$ ${produto.preco[0].toStringAsFixed(2).replaceAll('.', ',')}",
                        style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )
            : Row(
          children: <Widget>[
            //Dividindo a Row em duas com o mesmo tamanho
            Flexible(
              //Valor em proporção co o outro Flexible
              flex: 1,
              child: Image.network(
                produto.images[1],
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(produto.title, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      "R\$ ${produto.preco[0].toStringAsFixed(2).replaceAll('.', ',')}",
                      style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold),
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
