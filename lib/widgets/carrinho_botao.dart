import 'package:flutter/material.dart';
import 'package:lojavirtual2/screens/carrinho_screen.dart';

class CarrinhoBotao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      //Color.fromARGB(240, 255, 122, 173)
      backgroundColor: Colors.transparent,
      child: Icon(Icons.shopping_cart, color: Colors.white70),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CarrinhoScreen())
        );
      },
    );
  }
}
