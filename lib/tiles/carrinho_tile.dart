import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual2/datas/produto_carrinho.dart';
import 'package:lojavirtual2/datas/produto_data.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:provider/provider.dart';

//Uma vez que os produtos podem sofrer alterações de preços, por exemplo, é
//melhor salvar o ID do produto e buscar manualmente cada atributo. Dessa forma, ao fazer alguma alteração, será altomaticamente alterado
//no carrinho.
class CarrinhoTile extends StatelessWidget {
  final ProdutoCarrinho produtoCarrinho;

  CarrinhoTile(this.produtoCarrinho);

  @override
  Widget build(BuildContext context) {

    CarrinhoMobx carrinhoMobx =
    Provider.of<CarrinhoMobx>(context, listen: false);

    Widget _buildContent() {
    
    carrinhoMobx.setStatus();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 3.0),
            width: 120.0,
            child: Image.network(
              produtoCarrinho.produtoData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    produtoCarrinho.produtoData.title,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Porção: " +
                        produtoCarrinho.produtoData
                            .medida[produtoCarrinho.indexMedidaPreco],
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${produtoCarrinho.produtoData
                        .preco[produtoCarrinho.indexMedidaPreco]
                        .toStringAsFixed(2).toString().replaceAll('.', ',')}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: 125.0,
                        height: 30.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: TextFormField(
                                initialValue: '${produtoCarrinho.quantProdutos}',
                                onChanged: (text) {
                                  if(text.isEmpty)
                                    text = '0';

                                  if(text.length < 4){
                                    carrinhoMobx.quantidadeProduto(
                                        produtoCarrinho, int.parse(text));
                                    carrinhoMobx.validarPedido(produtoCarrinho);
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  helperMaxLines: 3,
                                  border: const OutlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 13),
                                  labelText: "Quantidade",
                                ),
                                cursorColor: Colors.grey,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3), //Definindo a quantidade de caractere
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: () {
                          carrinhoMobx.removerProduto(produtoCarrinho);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
//Espaçamento para fora do Widget
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: produtoCarrinho.produtoData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('produtos2')
                  .document(produtoCarrinho.idProduto)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  produtoCarrinho.produtoData =
                      ProdutoData.fromDocument(snapshot.data);
                      //Não pode fazer isso enquando está em um FutureBuilder
                     //Provider.of<CarrinhoMobx>(context).setTotal();
                  return _buildContent();
                } else {
                  return Container(
                    height: 70.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}