import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PedidosModel extends Model {
  FirebaseUser user;
  List<String> listPedidos = [];

  PedidosModel(this.user){
    if(user != null){
      _loadPedidos();
    }
  }

  static PedidosModel of(BuildContext context) =>
      ScopedModel.of<PedidosModel>(context);

  void add(String doc){
    listPedidos.add(doc);
  }

  void remover(String doc){

    listPedidos.remove(doc);

     Firestore.instance
        .collection('users').document(user.uid)
        .collection('pedidos')
        .document(doc)
        .delete();

     Firestore.instance
        .collection('pedidos')
        .document(doc)
        .delete();

    notifyListeners();
  }

  void _loadPedidos() async{

    QuerySnapshot querySnapshot = await Firestore.instance.collection('users')
        .document(user.uid).collection('pedidos').getDocuments();

    listPedidos = querySnapshot.documents.map((document) =>
        document.documentID).toList();

    notifyListeners();
  }


}