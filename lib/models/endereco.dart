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
  int enderecoCarrinhoIndex = -1;

  @observable
  bool enderecoEscolhido = false;

  @action
  Future<void> _loadEnderecos(FirebaseUser user) async {
    if (listEnderecos.length != 0) return;

    DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(user.uid).get();

    for (Map<dynamic, dynamic> endereco in doc.data['enderecos']) {
      listEnderecos.add(endereco);
      if (endereco['padrao']) {
        enderecoCarrinhoIndex = 0;
        enderecoEscolhido = true;
      }
    }
  }

  @action
  Future<void> excluirEndereco(Map<dynamic, dynamic> endereco) async {
    for (int i = 0; i < listEnderecos.length; i++) {
      if (endereco == listEnderecos[i]) {
        listEnderecos.remove(endereco);
        if (i == enderecoCarrinhoIndex) {
          if (listEnderecos[0]['padrao']) {
            enderecoCarrinhoIndex = 0;

          } else {
            resetEnderecoCarrinho();
            enderecoEscolhido = false;

          }
        }

        if(i < enderecoCarrinhoIndex){
          enderecoCarrinhoIndex--;

        }
        break;
      }
    }

    Firestore.instance.collection('users').document(user.uid).updateData({
      'enderecos': FieldValue.arrayRemove([endereco])
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
    if (listEnderecos[0]['padrao']) listEnderecos[0]['padrao'] = false;

    endereco['padrao'] = true;
    enderecoCarrinhoIndex = 0;
    enderecoEscolhido = true;

    listEnderecos.remove(endereco);
    listEnderecos.insert(0, endereco);

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'enderecos': listEnderecos});
  }

  @action
  void removerPadrao(Map<dynamic, dynamic> endereco) {
    if (enderecoCarrinhoIndex == 0) enderecoEscolhido = false;

    endereco['padrao'] = false;

    listEnderecos.remove(endereco);
    listEnderecos.insert(0, endereco);

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'enderecos': listEnderecos});
  }

  @action
  void resetEnderecoCarrinho() {
    enderecoCarrinhoIndex = -1;
    if (!listEnderecos[0]['padrao']) enderecoEscolhido = false;
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

    if (padrao) definirPadrao(endereco);

    Firestore.instance.collection('users').document(user.uid).updateData({
      'enderecos': FieldValue.arrayUnion([endereco])
    });
  }

  @action
  enderecoCarrinho(Map<dynamic, dynamic> endereco) {
    for (int i = 0; i < listEnderecos.length; i++) {
      if (endereco == listEnderecos[i]) {
        enderecoCarrinhoIndex = i;
        enderecoEscolhido = true;
        break;
      }
    }
  }
}
