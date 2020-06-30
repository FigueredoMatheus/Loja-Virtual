import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/pedidos_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/tiles/pedidos_tile.dart';
import 'package:lojavirtual2/widgets/nao_logado.dart';
import 'package:provider/provider.dart';

class PedidosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);
    
    return Observer(builder: (_) {
      print("Lista de pedidos(PedidosScreen): ${user.pedidos.listPedidos.length}");
      if (!user.isLoggedIn) {
        return NaoLogadoScreen(
            icon: Icons.view_list,
            text: "Faça o login para ver seus pedidos",
            color: Color.fromARGB(255, 211, 118, 130));
      } else if (user.pedidos.listPedidos.length == 0) {
        return Center(
          child: Text('Nenhum pedido encontrado.'),
        );
      } else {
        return ListView(
          children: <Widget>[
            Column(
                children: user.pedidos.listPedidos
                    .map((pedido) => PedidosTile(pedido))
                    .toList()),
          ],
        );
      }
    });
  }
}
