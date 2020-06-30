import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/widgets/nao_logado.dart';
import 'package:lojavirtual2/screens/finalizar_pedido_screen.dart';
import 'package:lojavirtual2/tiles/carrinho_tile.dart';
import 'package:lojavirtual2/widgets/card_cupom.dart';
import 'package:lojavirtual2/widgets/card_endereco.dart';
import 'package:lojavirtual2/widgets/card_preco.dart';
import 'package:provider/provider.dart';

class CarrinhoScreen extends StatefulWidget {
  @override
  _CarrinhoScreenState createState() => _CarrinhoScreenState();
}

//TODO CHAMAR SETTOTAL APENAS QUANDO TODOS OS ITENS DA LISTA FOREM DIFERENTE DE NULL
//TODO RESOLVER O SUBTOTAL E O DESCONTO QUANDO FOR DADO UM HOT RELOAD
class _CarrinhoScreenState extends State<CarrinhoScreen> {
  /*

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    when((_) => Provider.of<CarrinhoMobx>(context).status,
        Provider.of<CarrinhoMobx>(context).setTotal());
  }
  */

  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);
    CarrinhoMobx carrinhoMobx = Provider.of<CarrinhoMobx>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: Observer(builder: (_) {
              int itens = carrinhoMobx.listProdutosCarrinho.length;
              return Text('${itens ?? 0} ${itens == 1 ? 'ITEM' : 'ITENS'}');
            }),
          ),
        ],
      ),
      body: Observer(builder: (_) {
        if ((carrinhoMobx.getIsLoading) && (user.isLoggedIn)) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!user.isLoggedIn) {
          return NaoLogadoScreen(
            icon: Icons.remove_shopping_cart,
            text: "Faça login para ver seu carrinho.",
            color:  Theme.of(context).primaryColor,
            );
      
        } else if (carrinhoMobx.listProdutosCarrinho == null ||
            carrinhoMobx.listProdutosCarrinho.length == 0) {
          return Center(
            child: Text('Nenhum produto no carrinho!'),
          );
        } else {
          return ListView(
            children: <Widget>[
              Column(
                //Pegado cada item que está na lista e passando ele para um Card, dps passando os itens para uma lista
                children: carrinhoMobx.listProdutosCarrinho.map((prod) {
                  return CarrinhoTile(prod);
                }).toList(),
              ),
              CardDesconto(),
              CardEndereco(),
              CardPreco(() async {
                //print('${user.enderecoCarrinhoIndex]}');
                String pedidoId = await carrinhoMobx.finalizarPedido(
                    user.endereco.listEnderecos[user.endereco.enderecoCarrinhoIndex]).then((pedidoId){
                      user.pedidos.add(pedidoId);
                      return pedidoId;
                    });
                if (pedidoId != null) {
                  //pushReplacement com o botão de voltar, n irá voltar para a tela que ele foi chamado
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => FinalizarPedidoScreen(pedidoId)));

                  user.endereco.resetEnderecoCarrinho();
                }
              }),
            ],
          );
        }
      }),
    );
  }
}
