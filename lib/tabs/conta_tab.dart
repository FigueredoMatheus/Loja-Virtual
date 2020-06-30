import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lojavirtual2/models/user_mobx.dart';
import 'package:lojavirtual2/screens/changeNameScreen.dart';
import 'package:lojavirtual2/screens/enderecos_screen.dart';
import 'package:lojavirtual2/widgets/nao_logado.dart';
import 'package:provider/provider.dart';

class ContaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserMobx user = Provider.of<UserMobx>(context);

    return Observer(
      builder: (_) {
        if (!user.isLoggedIn) {
          return NaoLogadoScreen(
            icon: Icons.block, 
            text: "Faça login para ver sua conta.", 
            color: Theme.of(context).primaryColor,
            );

        } else if(user.getIsLoading){
          return Center(child: CircularProgressIndicator(),);
        } else {
          return ListView(
            children: <Widget>[
              Card(
                color: Colors.transparent,
                elevation: 20.0,
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 150,
                ),
              ),
              Card(
                elevation: 20.0,
                child: ExpansionTile(
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Observer(
                    builder: (_) {
                      return Text(user.userData['nome'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                      );
                    },
                  ),
                  onExpansionChanged: (x) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChangeNameScreen()));
                  },
                ),
              ),
              Card(
                elevation: 20.0,
                child: ExpansionTile(
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  title: Text(user.firebaseUser.email,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)),
                  onExpansionChanged: (x) {},
                ),
              ),
              Card(
                elevation: 20.0,
                child: ExpansionTile(
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  leading: Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                  ),
                  title: Text("*****",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)),
                  onExpansionChanged: (x) {},
                ),
              ),
              Card(
                elevation: 20.0,
                child: ExpansionTile(
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  leading: Icon(
                    Icons.add_location,
                    color: Colors.black,
                  ),
                  title: Text('Meus Endereços',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)),
                  onExpansionChanged: (x) {
                    //user.loadEnderecos();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EnderecosScreen()));
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
