import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LojasTile extends StatelessWidget {

  final DocumentSnapshot doc;

  LojasTile(this.doc);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              doc.data['image'],
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 4.0, top: 4.0),
            child: Text('${doc.data['rua']}, ${doc.data['numero']} -'
                ' ${doc.data['bairro']}, ${doc.data['cidade']} - ${doc.data['estado']}',
              style: TextStyle(fontSize: 15.0),
            ),
          ),

          SizedBox(height: 6.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text(
                    'Ver no Mapa',
                  style: TextStyle(color: Colors.blue,),
                ),
                onPressed: (){
                  launch('https://www.google.com/maps/search/?api=1&query=${doc.data['latitude']},${doc.data['longitude']}');
                },
              ),

              FlatButton(
                child: Text('Ligar', style: TextStyle(color: Colors.blue,),),
                onPressed: (){
                  launch('tel: ${doc.data['telefone']}');
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}
