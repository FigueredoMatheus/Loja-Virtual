import 'package:flutter/material.dart';

class FinalizarPedidoScreen extends StatelessWidget {
  final String pedidoId;

  FinalizarPedidoScreen(this.pedidoId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado!"),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
                Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),

            Text(
                "Pedido Realizado com Sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),

            Text(
                "Código do pedido: $pedidoId",
                style: TextStyle(fontSize: 16.0, ),
              ),

          ],
        ),
      ),
    );
  }
}
