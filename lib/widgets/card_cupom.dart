import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual2/models/carrinho_mobx.dart';
import 'package:provider/provider.dart';

class CardDesconto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CarrinhoMobx carrinhoMobx =  Provider.of<CarrinhoMobx>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      //Tem a opção de expandir e mostrar seu conteudo
      child: ExpansionTile(
        title: Text(
            "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        //Filhos para quando clicar em expandir
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Digite seu cupom",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              initialValue: carrinhoMobx.cupomCodigo ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection('cupom').document(text).get()
                    .then((doc){
                      if(doc.data != null){
                        carrinhoMobx.salvarCupom(text, doc.data['porcentagem']);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Desconto de ${doc.data['porcentagem']}% aplicado"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          )
                        );
                      }else{
                        carrinhoMobx.salvarCupom(null, 0);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Cupom inválido!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            )
                        );
                      }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
