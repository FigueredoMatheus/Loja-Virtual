import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:provider/provider.dart';

class CardPreco extends StatelessWidget {
  final VoidCallback buy;

  CardPreco(this.buy);

  @override
  Widget build(BuildContext context) {
    CarrinhoMobx carrinho = Provider.of<CarrinhoMobx>(context);
    UserMobx user = Provider.of<UserMobx>(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Resumo do pedido",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subtotal"),
                Observer(builder: (_) {
                  return Text(
                      "R\$ ${carrinho.subtotal.toStringAsFixed(2).replaceAll(".", ",")}");
                }),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Desconto"),
                Observer(builder: (_) {
                  return Text(
                      "R\$ ${carrinho.desconto.toStringAsFixed(2).replaceAll(".", ",")}");
                }),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Entrega"),
                Text(
                    "R\$ ${carrinho.entrega.toStringAsFixed(2).replaceAll(".", ",")}"),
              ],
            ),
            Divider(),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Observer(builder: (_) {
                  return Text(
                    "R\$ ${carrinho.total.toStringAsFixed(2).replaceAll(".", ",")}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Observer(builder: (_) {
              return SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text("Finalizar Pedido"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed:
                      carrinho.pedidoValido && user.endereco.enderecoEscolhido
                          ? buy
                          : null,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
