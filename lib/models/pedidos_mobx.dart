import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'pedidos_mobx.g.dart';

class PedidosMobx = _PedidosMobxBase with _$PedidosMobx;

abstract class _PedidosMobxBase with Store {

  final FirebaseUser user;
  
  _PedidosMobxBase(this.user){
    _loadPedidos(user);
  }

  @observable
  ObservableList<String> listPedidos = ObservableList<String>().asObservable();

  @action
  void add(String doc) {
    listPedidos.add(doc);
  }

  @action
  void remover(String doc, FirebaseUser user) {
    listPedidos.remove(doc);

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('pedidos')
        .document(doc)
        .delete();

    Firestore.instance.collection('pedidos').document(doc).delete();
  }

  void _loadPedidos(FirebaseUser user) async {
    print(user.uid);
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('pedidos')
        .getDocuments();

    listPedidos = querySnapshot.documents
        .map((document) => document.documentID)
        .toList()
        .asObservable();
  }
}
