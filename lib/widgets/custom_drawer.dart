import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/screens/login_screen.dart';
import 'package:lojavirtual2/tiles/drawer_tile.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
//Recebe o PageController que faz a mudança de páginas
//Quando clicar no botão do Drawer, fecha-lo e mudar de página
  final PageController pageController;

  CustomDrawer(this.pageController);

  //Tela de fundo
  Widget _buildDrawerBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(240, 255, 122, 173),
              Color.fromARGB(255, 245, 222, 179),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);
    CarrinhoMobx carrinhoMobx = Provider.of<CarrinhoMobx>(context);

    return  Drawer(
        child: Stack(
          children: <Widget>[
            _buildDrawerBack(),

            ListView(
              padding: EdgeInsets.only(left: 32.0, top: 16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                  height: 170.0,
                  //Stack os inves de Column pois é possivel passar a psição de cada elemento
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30.0,
                        left: 0.0,
                        child: Text(
                          "Pipocas da Tia Sônia",
                          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ),

                      Positioned(
                        left: 0.0,
                        bottom: 15.0,
                        //A única parte que muda são os dois textos
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Observer(
                              builder: (_){
                                return  Text(
                                  "Olá, ${!user.isLoggedIn ? "" : user.userNome}",
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white70),
                                );
                              },
                            ),
                            GestureDetector(
                              child: Observer(
                                builder: (_){
                                  return Text(
                                    !user.isLoggedIn ?
                                    "Entre ou cadastre-se >>" :
                                    "Sair"
                                    ,
                                    style: TextStyle(color: Color.fromARGB(255, 255, 122, 173),
                                        fontSize: 16.0, fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                              onTap: (){

                                if(!user.isLoggedIn) {
                                  print(carrinhoMobx.listProdutosCarrinho.length);
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen())
                                  );
                                }else{
                                  print(carrinhoMobx.listProdutosCarrinho.length);
                                  user.sair();
                                  print(carrinhoMobx.listProdutosCarrinho.length);
                                }

                              },
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Divider(),
                //Adicionando os botões
                //O INT de cada página corresponde a ordem que está no children de PageView
                DrawerTile(Icons.person, "Conta", pageController, 1),
                DrawerTile(Icons.home, "Início", pageController, 0),
                DrawerTile(Icons.menu, "Cardápio", pageController, 2),
                DrawerTile(Icons.location_on, "Lojas", pageController, 3),
                DrawerTile(Icons.playlist_add_check, "Meus pedidos", pageController, 4),
              ],
            ),
          ],
        ),
      );
  }
}
