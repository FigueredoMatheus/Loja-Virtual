import 'package:flutter/material.dart';
import 'package:lojavirtual2/screens/login_screen.dart';

class NaoLogadoScreen extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color color;

  NaoLogadoScreen({@required this.icon,@required this.text,@required this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Icon(
                icon,
                color: color,
                size: 80.0,
              ),
          
              SizedBox(
                height: 16.0,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18.0),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        );
  }
}