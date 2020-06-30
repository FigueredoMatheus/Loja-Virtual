import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/datas/produto_carrinho.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/screens/carrinho_screen.dart';
import 'package:lojavirtual2/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProdutoScreen extends StatefulWidget {
  final ProdutoData produto;

  ProdutoScreen(this.produto);

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  int _indexMedidaPreco = 0;
  String medidaOp = "";

  void initState() {
    super.initState();
    medidaOp = produto.medida[0];
  }

  final ProdutoData produto;

  _ProdutoScreenState(this.produto);

  dynamic precoView() {
    for (_indexMedidaPreco = 0;
    _indexMedidaPreco < produto.medida.length;
    _indexMedidaPreco++) {
      if (medidaOp == produto.medida[_indexMedidaPreco]) {
        return produto.preco[_indexMedidaPreco];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);
    CarrinhoMobx carrinhoMobx = Provider.of<CarrinhoMobx>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(produto.title),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            //Tamanho fixo da imagem para cada tamanho de celular
            AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: produto.images.map((url) {
                  return Image.network(url);
                }).toList(),
                //Pontos quanto está mudando de imagem
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: Colors.black,
                dotIncreasedColor: Colors.black,
                //Mudar automaticamente de tela
                autoplay: false,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    produto.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                 Text(
                        "R\$ ${precoView().toStringAsFixed(2).toString().replaceAll('.', ',')}",
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),

                  SizedBox(height: 16.0),
                  Text(
                    "Porção:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 34.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: produto.medida.map((medida) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              medidaOp = medida;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.0, left: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                  color: medidaOp == medida
                                      ? Colors.green
                                      : Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(medida),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: Observer(builder: (_) {
                      return RaisedButton(
                        child: Text(user.isLoggedIn
                            ? "Adicionar ao carrinho"
                            : "Entre para comprar"),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: user.isLoggedIn
                            ? () {
                                ProdutoCarrinho produtoCarrinho =
                                    ProdutoCarrinho();
                                //produtoCarrinho.medida = medidaOp;
                                produtoCarrinho.quantProdutos = 1;
                                produtoCarrinho.idProduto = produto.id;
                                produtoCarrinho.produtoData = this.produto;
                                produtoCarrinho.indexMedidaPreco =
                                    _indexMedidaPreco;

                                carrinhoMobx.addProduto(produtoCarrinho);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CarrinhoScreen())
                                );
                              }
                            : () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                      );
                    }),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Descrição",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    produto.descricao,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
