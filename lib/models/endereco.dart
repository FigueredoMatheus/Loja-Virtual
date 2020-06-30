import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'endereco.g.dart';

class Endereco = _EnderecoBase with _$Endereco;

abstract class _EnderecoBase with Store {
  final FirebaseUser user;

  _EnderecoBase(this.user) {
    _loadEnderecos(user);
  }

  @observable
  ObservableList<Map<dynamic, dynamic>> listEnderecos =
      ObservableList<Map<dynamic, dynamic>>().asObservable();

  @observable
  Map<dynamic, dynamic> enderecoEscolhidoo;

  @action
  Future<void> _loadEnderecos(FirebaseUser user) async {
    if (listEnderecos.length != 0) return;

    DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(user.uid).get();

    for (Map<dynamic, dynamic> endereco in doc.data['enderecos']) {
      listEnderecos.add(endereco);
      if (endereco['padrao']) {
        enderecoEscolhidoo = endereco;
      }
    }
  }

  @action
  Future<void> excluirEndereco(Map<dynamic, dynamic> endereco) async {
    listEnderecos.remove(endereco);

    if(endereco == enderecoEscolhidoo){
      if(listEnderecos.isNotEmpty && listEnderecos[0]['padrao']){
        enderecoEscolhidoo = listEnderecos[0];
      }else{
        enderecoEscolhidoo = null;
      }

    }

    Firestore.instance.collection('users').document(user.uid).updateData({
      'enderecos': FieldValue.arrayRemove([endereco])
    });

  }

   @action
  void adicionarEndereco(
      {@required String rua,
      @required String bairro,
      @required String cidade,
      @required String estado,
      @required String numero,
      @required String cep,
      @required bool padrao,
      String complemento}) {
    Map<String, dynamic> endereco = Map<String, dynamic>();

    endereco = {
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'numero': numero,
      'cep': cep,
      'padrao': padrao,
      'complemento': complemento.isEmpty ? "" : complemento,
    };

    listEnderecos.add(endereco);

    if(padrao)definirPadrao(endereco);
  
    Firestore.instance.collection('users').document(user.uid).updateData({
      'enderecos': FieldValue.arrayUnion([endereco])
    });
  }

  @action
  void editarEndereco(Map<dynamic, dynamic> endereco) {
    for (int i = 0; i < listEnderecos.length; i++) {
      if (listEnderecos[i] == endereco) {
        listEnderecos.removeAt(i);
        listEnderecos.insert(i, endereco);
      }
    }

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'enderecos': listEnderecos});
  }

  @action
  void definirPadrao(Map<dynamic, dynamic> endereco) {

    if(_temPadrao()){

      if(listEnderecos[0] == enderecoEscolhidoo || enderecoEscolhidoo == null)
        enderecoEscolhidoo = endereco;

      listEnderecos[0]['padrao'] = false;
    }else{
      if(enderecoEscolhidoo == null){
        enderecoEscolhidoo = endereco;
      }

    }

    endereco['padrao'] = true;

    listEnderecos.remove(endereco);
    listEnderecos.insert(0, endereco);

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'enderecos': listEnderecos});
  }

  @action
  void removerPadrao(Map<dynamic, dynamic> endereco) {
  
    if(endereco == enderecoEscolhidoo)
      enderecoEscolhidoo = null;

    listEnderecos.remove(endereco);

    endereco['padrao'] = false;

    listEnderecos.insert(0, endereco);

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'enderecos': listEnderecos});
  }

  @action
  void resetEnderecoCarrinho() {
    if (listEnderecos[0]['padrao']) 
      enderecoEscolhidoo = listEnderecos[0];
    else
      enderecoEscolhidoo = null;
  }

  bool _temPadrao(){
    if(listEnderecos.isEmpty){
      return false;
    }else if(listEnderecos[0]['padrao']){
      return true;
    }

    return false;
  }
}
