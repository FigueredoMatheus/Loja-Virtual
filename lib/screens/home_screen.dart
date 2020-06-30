import 'package:flutter/material.dart';
import 'package:lojavirtual2/tabs/conta_tab.dart';
import 'package:lojavirtual2/tabs/home_tab.dart';
import 'package:lojavirtual2/tabs/lojas_tab.dart';
import 'package:lojavirtual2/tabs/pedidos_tab.dart';
import 'package:lojavirtual2/tabs/produtos_grid_tab.dart';
import 'package:lojavirtual2/widgets/custom_drawer.dart';
import 'package:lojavirtual2/screens/carrinho_screen.dart';

class HomeScreen extends StatelessWidget {
  //Usado para troca de paginas
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //PageView permite ficar arrastando as telas que são seus children
    //Quando tiver muitas telas, usar esse Widget q tem um mehlro suporte
    return PageView(
      //Não permite trocar as telas arrastando, apenas com um controlador que será o Menu
      //Dessa forma, pode-se adicionar a opção de Menu
      physics: NeverScrollableScrollPhysics(),
      //Esse controler será passado como parametro para o Drawer
      controller: _pageController,
      children: <Widget>[
        //Página Home
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          // floatingActionButton: CarrinhoBotao(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Conta"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 211, 118, 130),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                color: Color.fromARGB(240, 255, 122, 173),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CarrinhoScreen()));
                },
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 253, 181, 168),
          drawer: CustomDrawer(_pageController),
          body: ContaTab(),
        ),

        //Pagina de produtos
        Scaffold(
          appBar: AppBar(
            title: Text("Cardápio"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 211, 118, 130),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                color: Color.fromARGB(240, 255, 122, 173),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CarrinhoScreen()));
                },
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 253, 181, 168),
          drawer: CustomDrawer(_pageController),
          body: ProdutosGridTab(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Localização"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 211, 118, 130),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                color: Color.fromARGB(240, 255, 122, 173),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CarrinhoScreen()));
                },
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 253, 181, 168),
          drawer: CustomDrawer(_pageController),
          body: LojasTab(),
          // floatingActionButton: CarrinhoBotao(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 211, 118, 130),
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
          ),
          backgroundColor: Color.fromARGB(255, 253, 181, 168),
          drawer: CustomDrawer(_pageController),
          body: PedidosTab(),
        ),
      ],
    );
  }
}
