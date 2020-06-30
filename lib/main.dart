import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:lojavirtual2/models/pedidos_mobx.dart';
import 'package:lojavirtual2/screens/home_screen.dart';
import 'package:lojavirtual2/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_mobx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Quando trocar de usuário, todo o App será modificado de acordo com o usuário
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => UserMobx(),
        ),
        ChangeNotifierProxyProvider<UserMobx, CarrinhoMobx>(
            create: null,
            lazy: false,
            update: (_, userMobx, __) {
              return CarrinhoMobx(userMobx);
            }),
      ],
      child: MaterialApp(
        title: "Pipocas da Tia Sônia",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            //O primeiro é a opacidade da cor de 0 a 255
            primaryColor:
                Color.fromARGB(255, 4, 125, 141) //Cor na App bar, icones, etc
            ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

/*
     ChangeNotifierProvider(
      lazy: false,
      create: (_) => UserMobx(),
      child: ProxyProvider<UserMobx, CarrinhoMobx>(
        lazy: false,
        update: (_, userMobx, __) {
          print("Main: ${userMobx.firebaseUser}");
          return CarrinhoMobx(userMobx);
        },
          child: MaterialApp(
            title: "Pipocas da Tia Sônia",
            theme: ThemeData(
                primarySwatch: Colors.blue,
                //O primeiro é a opacidade da cor de 0 a 255
                primaryColor: Color.fromARGB(
                    255, 4, 125, 141) //Cor na App bar, icones, etc
                ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        ),
      );
 */
